import SwiftUI

struct LiquidGlassView: View {
    @StateObject var viewModel: SwiftUIDemoViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                glassTitle

                glassButtons

                GlassSlider(
                    sliderValue: $viewModel.sliderValue
                )

                GlassPickers(
                    selectedOption: $viewModel.selectedOption,
                    options: viewModel.options
                )

                DatePickerView(
                    date: $viewModel.date
                )

                ModalButtons(
                    showSheet: $viewModel.showSheet,
                    showPopover: $viewModel.showPopover,
                    showAlert: $viewModel.showAlert
                )

                FloatingActionButton(
                    isPressed: $viewModel.isPressed,
                )

                GlassImagesRow(
                    isExpanded: $viewModel.isExpanded
                )

                AnimatableCircleView(
                    isExpandedCircle: $viewModel.isExpandedCircle
                )

                Spacer(minLength: 80)
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.showSheet) {
            SheetContent()
        }
        .popover(isPresented: $viewModel.showPopover) {
            PopoverContent()
        }
        .alert("Alert", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
            Button("Delete", role: .destructive) {}
        }
    }

    private var glassTitle: some View {
        Text("Liquid Glass")
            .font(.largeTitle.bold())
            .padding()
            .glassEffect(in: .rect(cornerRadius: 16))
    }

    private var glassButtons: some View {
        GlassEffectContainer(spacing: 40) {
            HStack(spacing: 40) {
                Button("1") {}
                    .frame(width: 80, height: 80)
                    .buttonStyle(.borderedProminent)
                    .glassEffect()

                Button("2") {}
                    .frame(width: 80, height: 80)
                    .buttonStyle(.glass)
                    .glassEffect()
                    .offset(x: -40)

                Button("Glass") {}
                    .buttonStyle(.glass)
            }
        }
    }
}
