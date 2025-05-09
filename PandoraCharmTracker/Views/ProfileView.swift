import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var charmVM: CharmViewModel
    @State private var selectedTab = "Collection"
    @AppStorage("bio") private var bio: String = "Collector of memories, not just charms."
    @AppStorage("profilePicName") private var profilePicName: String = ""
    @State private var isEditingBio = false
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?

    let tabs = ["Collection", "Wishlist", "Friends"]

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // MARK: Profile Info
                VStack {
                    Button {
                        showingImagePicker = true
                    } label: {
                        if let image = loadProfileImage() {
                            Image(uiImage: image)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray)
                        }
                    }

                    Text("Shawn Conboy").font(.title2).bold()

                    if isEditingBio {
                        TextField("Enter your bio", text: $bio)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        Button("Done") {
                            isEditingBio = false
                        }
                    } else {
                        Text(bio)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button("Edit Bio") {
                            isEditingBio = true
                        }
                        .font(.caption)
                    }
                }

                // MARK: Stats
                HStack(spacing: 40) {
                    VStack {
                        Text("\(charmVM.ownedCharms.count)").font(.title3).bold()
                        Text("Charms").font(.caption)
                    }
                    VStack {
                        Text("\(charmVM.wishlistCharms.count)").font(.title3).bold()
                        Text("Wishlist").font(.caption)
                    }
                    VStack {
                        Text("12").font(.title3).bold()
                        Text("Friends").font(.caption)
                    }
                }

                // MARK: Section Picker
                Picker("Tab", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // MARK: Section Content
                ScrollView {
                    if selectedTab == "Collection" {
                        CollectionGridView(charms: charmVM.ownedCharms)
                    } else if selectedTab == "Wishlist" {
                        WishlistGridView(charms: charmVM.wishlistCharms)
                    } else {
                        FriendsListView()
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage, onImagePicked: { image in
                    saveProfileImage(image)
                })
            }
            .padding()
            .navigationTitle("My Profile")
        }
    }

    // MARK: Helpers
    func loadProfileImage() -> UIImage? {
        guard !profilePicName.isEmpty else { return nil }
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(profilePicName)
        return UIImage(contentsOfFile: url.path)
    }

    func saveProfileImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let filename = UUID().uuidString + ".jpg"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
        do {
            try data.write(to: url)
            profilePicName = filename
        } catch {
            print("Failed to save image: \(error)")
        }
    }
}
