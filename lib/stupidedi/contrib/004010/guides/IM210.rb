# frozen_string_literal: true

module Stupidedi
  module Contrib
    module FortyTen
      module Guides

        b = GuideBuilder
        d = Schema
        r = SegmentReqs
        e = ElementReqs
        s = Versions::FunctionalGroups::FortyTen::SegmentDefs
        t = Contrib::FortyTen::TransactionSetDefs

        #
        # Motor Carrier Freight Details and Invoice
        #
        IM210 = b.build(t::IM210,
          d::TableDef.header("Heading",
            b::Segment(10, s::ST, "Transaction Set Header",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transaction Set Identifier Code", b::Values("210")),
              b::Element(e::Required,    "Transaction Set Control Number")),

            b::Segment(20, s::B3, "Beginning Segment for Carrier's Invoice",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::NotUsed,    "Shipment Qualifier"),
              b::Element(e::Required,    "Invoice Number"),
              b::Element(e::Required,    "Shipment Identification Number"),
              b::Element(e::Required,    "Shipment Method of Payment"),
              b::Element(e::NotUsed,     "Weight Unit Code"),
              b::Element(e::Required,   "Date"),
              b::Element(e::Required,   "Net Amount Due"),
              b::Element(e::Situational,     "Correction Indicator"),
              b::Element(e::Situational,   "Delivery Date"),
              b::Element(e::Situational,   "Date/Time Qualifier"),
              b::Element(e::Required,   "Standard Carrier Alpha Code")),

            b::Segment(40, s::C3, "Currency",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Currency Code"),
              b::Element(e::Situational,    "Exchange Rate"),
              b::Element(e::Situational,    "Currency Code")),

            b::Segment(60, s::N9, "Reference Identification",
              r::Situational, d::RepeatCount.bounded(300),
              b::Element(e::Required, "Reference Identification Qualifier"),
              b::Element(e::Situational, "Reference Identification")),

            b::Segment(70, s::G62, "Date/Time",
              r::Situational, d::RepeatCount.bounded(1),
              b::Element(e::Situational, "Date Qualifier"),
              b::Element(e::Situational, "Date"),
              b::Element(e::Situational, "Time Qualifier"),
              b::Element(e::Situational, "Time"),
              b::Element(e::NotUsed,     "Time Code")),

            b::Segment(80, s::R3, "Route Information - Motor",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Standard Carrier Alpha Code"),
              b::Element(e::Required,    "Routing Sequence Code"),
              b::Element(e::Situational, "City Name"),
              b::Element(e::Situational, "Transport Method/Type Code"),
              b::Element(e::Situational, "Standard Point Location Code"),
              b::Element(e::Situational, "Invoice Number"),
              b::Element(e::Situational, "Date"),
              b::Element(e::Situational, "Amount"),
              b::Element(e::Situational, "Free-form Description")),

            b::Segment(90, s::H3, "Line Item - Quantity and Weight",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Situational, "Special Handling Code"),
              b::Element(e::Situational, "Special Handling Description"),
              b::Element(e::Situational, "Protective Service Code"),
              b::Element(e::Situational, "Vent Instruction Code Code"),
              b::Element(e::Situational, "Tariff Application Code")),

            d::LoopDef.build("0100",
              d::RepeatCount.bounded(1),
              b::Segment(110, s::N1, "Name",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Entity Identifier Code"),
                b::Element(e::Required,    "Name"),
                b::Element(e::Situational, "Identification Code Qualifier"),
                b::Element(e::Situational, "Identification Code"),
                b::Element(e::Situational, "Entity Relation Code"),
                b::Element(e::Situational, "Entity Identifier Code")),

              b::Segment(130, s::N3, "Address Information",
                r::Required, d::RepeatCount.bounded(2),
                b::Element(e::Situational, "Address Information"),
                b::Element(e::Situational, "Address Information")),

              b::Segment(140, s::N4, "Geographic Information",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Situational, "City Name"),
                b::Element(e::Situational, "State or Province Code"),
                b::Element(e::Situational, "Postal Code"),
                b::Element(e::Situational, "Country Code"),
                b::Element(e::Situational, "Location Qualifier"),
                b::Element(e::Situational, "Location Identifier")),

              b::Segment(150, s::N9, "Reference Identification",
                r::Required, d::RepeatCount.bounded(5),
                b::Element(e::Situational, "Reference Identification"),
                b::Element(e::Situational, "Reference Identification Qualifier"))),

            d::LoopDef.build("0200",
              d::RepeatCount.bounded(10),
              b::Segment(160, s::N7, "Equipment Details",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Situational, "Equipment Initial"),
                b::Element(e::Situational, "Equipment Number"),
                b::Element(e::NotUsed,     "Weight"),
                b::Element(e::NotUsed,     "Weight Qualifier"),
                b::Element(e::NotUsed,     "Tare Weight"),
                b::Element(e::NotUsed,     "Weight Allowance"),
                b::Element(e::NotUsed,     "Dunnage"),
                b::Element(e::NotUsed,     "Volume"),
                b::Element(e::NotUsed,     "Volume Qualifier"),
                b::Element(e::NotUsed,     "Ownership Code"),
                b::Element(e::Situational, "Equipment Description Code"),
                b::Element(e::NotUsed,     "Standard Carrier Alpha Code"),
                b::Element(e::NotUsed,     "Temperature Control"),
                b::Element(e::NotUsed,     "Position"),
                b::Element(e::Situational, "Equipment Length"),
                b::Element(e::NotUsed,     "Tare Qualifier Code"),
                b::Element(e::NotUsed,     "Weight Unit Code"),
                b::Element(e::NotUsed,     "Equipment Number Check Digit"),
                b::Element(e::NotUsed,     "Type of Service Code"),
                b::Element(e::NotUsed,     "Height"),
                b::Element(e::NotUsed,     "Width"),
                b::Element(e::NotUsed,     "Equipment Type"),
                b::Element(e::NotUsed,     "Standard Carrier Alpha Code"),
                b::Element(e::NotUsed,     "Car Type Code")))),

          d::TableDef.header("Detail",
            d::LoopDef.build("0400",
              d::RepeatCount.bounded(9999),
              b::Segment(120, s::LX, "Assigned Number",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,  "Assigned Number")),

              b::Segment(130, s::N9, "Reference Identification",
                r::Required, d::RepeatCount.bounded(5),
                b::Element(e::Situational, "Reference Identification"),
                b::Element(e::Situational, "Reference Identification Qualifier")),

              b::Segment(140, s::L5, "Description, Marks and Numbers",
                r::Required, d::RepeatCount.bounded(30),
                b::Element(e::Situational,  "Lading Line Item Number"),
                b::Element(e::Situational,  "Lading Description"),
                b::Element(e::Situational,  "Commodity Code"),
                b::Element(e::Situational,  "Commodity Code Qualifier"),
                b::Element(e::NotUsed,      "Packaging Code"),
                b::Element(e::NotUsed,      "Marks and Numbers"),
                b::Element(e::NotUsed,      "Marks and Numbers Qualifier"),
                b::Element(e::NotUsed,      "Commodity Code"),
                b::Element(e::NotUsed,      "Commodity Code Qualifier"),
                b::Element(e::NotUsed,      "Compartment ID Code")),

              b::Segment(170, s::L0, "Line Item -- Quantity and Weight",
                r::Required, d::RepeatCount.bounded(10),
                b::Element(e::Situational,  "Lading Line Item Number"),
                b::Element(e::Situational,  "Billed/Rated-as Quantity"),
                b::Element(e::Situational,  "Billed/Rated-as Qualifier"),
                b::Element(e::Situational,  "Weight"),
                b::Element(e::Situational,  "Weight Qualifier"),
                b::Element(e::Situational,  "Volume"),
                b::Element(e::Situational,  "Volume Qualifier"),
                b::Element(e::Situational,  "Lading Quantity"),
                b::Element(e::Situational,  "Packaging Form Code")),

              b::Segment(180, s::L1, "Rate and Charges",
                r::Required, d::RepeatCount.bounded(10),
                b::Element(e::Situational,  "Lading Line Item Number"),
                b::Element(e::Situational,  "Freight Rate"),
                b::Element(e::Situational,  "Rate/Value Qualifier"),
                b::Element(e::Situational,  "Charge"),
                b::Element(e::Situational,  "Advances"),
                b::Element(e::Situational,  "Prepaid Amount"),
                b::Element(e::Situational,  "Rate Combination Point Code"),
                b::Element(e::Situational,  "Special Charge or Allowance Code"),
                b::Element(e::Situational,  "Rate Class Code"),
                b::Element(e::Situational,  "Entitlement Code"),
                b::Element(e::Situational,  "Charge Method of Payment"),
                b::Element(e::Situational,  "Special Charge Description"),
                b::Element(e::Situational,  "Tariff Application Code"),
                b::Element(e::Situational,  "Declared Value"),
                b::Element(e::Situational,  "Rate/Value Qualifier"),
                b::Element(e::Situational,  "Lading Liability Code"),
                b::Element(e::Situational,  "Billed/Rated-as Quantity"),
                b::Element(e::Situational,  "Billed/Rated-as Qualifier"),
                b::Element(e::Situational,  "Percent")),

              b::Segment(190, s::L4, "Measurement",
                r::Required, d::RepeatCount.bounded(10),
                b::Element(e::Situational,  "Length"),
                b::Element(e::Situational,  "Width"),
                b::Element(e::Situational,  "Height"),
                b::Element(e::Situational,  "Measurement Qualifier"),
                b::Element(e::Situational,  "Quantity")),

              b::Segment(200, s::L7, "Measurement",
                r::Required, d::RepeatCount.bounded(10),
                b::Element(e::Situational,  "Lading Line Item Number"),
                b::Element(e::Situational,  "Tariff Agency Code"),
                b::Element(e::Situational,  "Tariff Number"),
                b::Element(e::Situational,  "Tariff Section"),
                b::Element(e::Situational,  "Tariff Item Number"),
                b::Element(e::Situational,  "Tariff Item Part"),
                b::Element(e::Situational,  "Freight Class Code"),
                b::Element(e::Situational,  "Tariff Supplement Identifier"),
                b::Element(e::Situational,  "Ex Parte"),
                b::Element(e::Situational,  "Date"),
                b::Element(e::Situational,  "Rate Base Number"),
                b::Element(e::Situational,  "Tariff Column"),
                b::Element(e::Situational,  "Tariff Distance"),
                b::Element(e::Situational,  "Distance Qualifier"),
                b::Element(e::Situational,  "City Name"),
                b::Element(e::Situational,  "State or Province Code")))),

          d::TableDef.header("Summary",
            b::Segment(10, s::L3, "Total Weight and Charges",
              r::Situational, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Weight"),
              b::Element(e::Required,    "Weight Qualifier"),
              b::Element(e::Situational, "Freight Rate"),
              b::Element(e::Situational, "Rate/Value Qualifier"),
              b::Element(e::Situational, "Charge"),
              b::Element(e::NotUsed,     "Not Available"),
              b::Element(e::NotUsed,     "Not Available"),
              b::Element(e::NotUsed,     "Not Available"),
              b::Element(e::Situational, "Volume"),
              b::Element(e::Situational, "Volume Unit Qualifier"),
              b::Element(e::NotUsed,     "Not Available"),
              b::Element(e::NotUsed,     "Not Available"),
              b::Element(e::NotUsed,     "Not Available"),
              b::Element(e::Situational, "Declared Value"),
              b::Element(e::Situational, "Rate/Value Qualifier")),

            b::Segment(20, s::SE, "Transaction Set Trailer",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Situational, "Number of Included Segments"),
              b::Element(e::Situational, "Transaction Set Control Number"))))

      end
    end
  end
end
