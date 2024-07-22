import XCTest
@testable import GymApp

class WorkoutServiceTests: XCTestCase {
    
    var workoutService: WorkoutService!
    var yearViewModel: YearViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        workoutService = WorkoutService()
        yearViewModel = YearViewModel()
    }
    
    override func tearDownWithError() throws {
        workoutService = nil
        yearViewModel = nil
        super.tearDown()
    }
    
    func testAddWorkout() throws {
        // Test adding a workout
        let id1 = workoutService.addWorkout(viewModel: yearViewModel)
        let id2 = workoutService.addWorkout(viewModel: yearViewModel)
        
        // Verify the workout was added correctly
        let year = yearViewModel.years.first { $0.year == Calendar.current.component(.year, from: Date()) }
        print("Year: \(year!.year)")
        XCTAssertNotNil(year, "Year should not be nil")
        XCTAssert(yearViewModel.years.count == 1, "Only 1 year should be added.")
        
        let month = year?.months.first { $0.monthNumber == Calendar.current.component(.month, from: Date()) }
        print(month!)
        XCTAssertNotNil(month, "Month should not be nil")
        
        let day = month?.days.first { $0.dayNumber == Calendar.current.component(.day, from: Date()) }
        print("Day: \(day!.dayNumber)")
        XCTAssertNotNil(day, "Day should not be nil")
        
        let workout1 = day?.workouts.first { $0.id == id1 }
        XCTAssertNotNil(workout1, "Workout should not be nil")
        
        let workout2 = day?.workouts.first { $0.id == id2 }
        XCTAssertNotNil(workout2, "Workout should not be nil")
    }
}
