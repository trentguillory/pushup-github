import SwiftUI

// MARK: - ProfileHeaderView

struct ProfileHeaderView: View {
    // MARK: Internal

    @ObservedObject var viewModel: ProfileHeaderViewModel

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    AsyncImage(url: viewModel.userImage) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 24, height: 24)
                    .background(Color.gray)
                    .clipShape(Circle())

                    Text(viewModel.username)

                    Spacer()
                }

                HStack {
                    userMetric(label: "Followers", value: viewModel.followers)
                    userMetric(label: "Following", value: viewModel.following)
                    if !viewModel.stars.isEmpty {
                        userMetric(label: "Stars", value: viewModel.stars)
                    }

                    Spacer()
                }
            }
            .padding(.bottom, 4)
            .background(backgroundColor)

            LinearGradient(gradient: .init(colors: [backgroundColor, .clear]), startPoint: .top, endPoint: .bottom)
                .frame(height: 12)
        }
        .padding([.leading, .trailing])
    }

    // MARK: Private

    @Environment(\.colorScheme) private var colorScheme

    private var backgroundColor: Color {
        switch colorScheme {
        case .dark: return .black
        case .light: return .white
        default: return .white
        }
    }

    private func userMetric(label: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(value)
                .fontWeight(.medium)
            Text(label)
                .font(.system(size: 12))
        }
    }
}
