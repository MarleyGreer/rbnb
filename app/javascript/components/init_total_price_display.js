
const initTotalPriceDisplay = () => {
  const totalPrice = document.querySelector(".total-price-display")
  if ( !totalPrice ) return
  const totalPriceDisplay = totalPrice.querySelector("span.total-price")
  totalPriceDisplay.innerText = "N/A"

  const garmentPriceElement = document.querySelector("span.garment-price")
  const garmentPrice = Number(garmentPriceElement.innerText, 10)

  const formDates = document.querySelector(".dates")
  const startDateInput = formDates.querySelector("#booking_start_date")
  const endDateInput = formDates.querySelector("#booking_end_date")

  startDateInput.addEventListener('change', (event) => {
    const startDate = startDateInput.value
    const endDate = endDateInput.value
    const bookingStartDate = new Date(startDate)
    const bookingEndDate = new Date(endDate)
    const bookingDays = (bookingEndDate - bookingStartDate) / 86400000
    const totalBookingPrice = bookingDays * garmentPrice
    totalPriceDisplay.innerText = totalBookingPrice
  });

  endDateInput.addEventListener('change', (event) => {
    const startDate = startDateInput.value
    const endDate = endDateInput.value
    const bookingStartDate = new Date(startDate)
    const bookingEndDate = new Date(endDate)
    const bookingDays = (bookingEndDate - bookingStartDate) / 86400000
    const totalBookingPrice = bookingDays * garmentPrice
    totalPriceDisplay.innerText = totalBookingPrice
  });
}

export { initTotalPriceDisplay }
