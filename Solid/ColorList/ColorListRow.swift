import Defaults
import SwiftUI

struct ColorListRow: View {
    var color: SolidColor

    var body: some View {
        _ColorListRow(
            color: NSColor(
                colorSpace: ColorSpace(rawValue: color.colorSpace!)!
                    .nsColorSpace,
                hue: color.hue,
                saturation: color.saturation,
                brightness: color.brightness,
                alpha: color.alpha
            ),
            name: color.name ?? ""
        )
    }
}

struct _ColorListRow: View {
    @Default(.includeHashPrefix) private var includeHashPrefix
    @Default(.lowerCaseHex) private var lowerCaseHex

    var color: NSColor
    var name: String

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color(nsColor: color))
                .frame(width: 44, height: 44)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)

                Text(hexString)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }

    private var hexString: String {
        let prefix = includeHashPrefix ? "#" : ""

        let hex = (prefix + color.hexString)

        if lowerCaseHex {
            return hex
        } else {
            return hex.uppercased()
        }
    }
}

struct ColorListRow_Previews: PreviewProvider {
    static var previews: some View {
        _ColorListRow(
            color: .red,
            name: "red"
        )
        .frame(width: 320)
    }
}
