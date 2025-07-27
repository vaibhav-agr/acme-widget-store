# Acme Widget Co Sales System

POC for Acme Widget Co's sales system, implementing a shopping basket, special offers, and delivery charges.

## Design

The system follows SOLID principles and uses dependency injection for flexibility. Key components:

- `Product`: Product model with code, name, and price
- `ProductCatalogue`: Manages the product inventory and lookup
- `Offer`: Abstract class for implementing special offers
- `BuyOneGetSecondHalfPrice`: Promotional offer implementation
- `DeliveryCharge`: Calculates delivery charges based on net total
- `Basket`: Main class handling the shopping basket functionality

## Running Tests

To run the tests:

```bash
ruby test/basket_test.rb
```

## Assumptions

1. Delivery charges are applied after discounts
2. For the "buy one get second half price" offer:
   - Applies to pairs of items
   - Multiple pairs in the same basket get the same discount
   - Three items = one pair discounted + one full price
