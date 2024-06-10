import SwiftUI

struct WeeklyCalendarView: View {
    @State private var currentWeek: Date = Date()

    var body: some View {
        VStack {
            Text("Weekly Calendar")
                .font(.largeTitle)
                .padding()

            HStack {
                ForEach(0..<7, id: \.self) { offset in
                    Text(self.dateString(for: offset))
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .background(Color.gray.opacity(0.1))
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 {
                            // Swipe left
                            self.currentWeek = self.changeWeek(by: 1)
                        } else if value.translation.width > 0 {
                            // Swipe right
                            self.currentWeek = self.changeWeek(by: -1)
                        }
                    }
            )
        }
        .padding()
    }

    private func dateString(for offset: Int) -> String {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentWeek))!
        let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func changeWeek(by weeks: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .weekOfYear, value: weeks, to: currentWeek)!
    }
}

struct WeeklyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCalendarView()
    }
}
