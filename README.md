# Vending Partnerships through Keys

This repository holds a set of PHP classes designed to support public
sign up of Partners. Those Partners are allowed to extend Models which
are XML documents with identified substitution points. When Partners
extend Models they may specify values or upload files as assets to be
to be built into the Models. Setting the permanent and optionally
identifying default assets creates a new Product for that partner.

## Object hierarchy objectives

Each substitution in a Model may be locked by the Partner or
identified as extendable by the Customer when that Product Order is
created. The system provides a vendor price for Models and allows the
Partner to set the retail price of each Product.

Orders include shipping Label information and allow the Customer to
identify and reuse multiple Destinations. Order processing
accommodates multiple Items, external transaction clearing and
culminates with XML Order submission to the "# Vending Partnerships through Keys

This repository holds a set of PHP classes designed to support public
sign up of Partners. Those Partners are allowed to extend Models which
are XML documents with identified substitution points. When Partners
extend Models they may specify values or upload files as assets to be
to be built into the Models. Setting the permanent and optionally
identifying default assets creates a new Product for that partner.

## Object hierarchy objectives

Each substitution in a Model may be locked by the Partner or
identified as extendable by the Customer when that Product Order is
created. The system provides a vendor price for Models and allows the
Partner to set the retail price of each Product.

Orders include shipping Label information and allow the Customer to
identify and reuse multiple Destinations. Order processing
accommodates multiple Items, external transaction clearing and
culminates with XML Order submission to the "factory".

A recording http endpoint tracks progress by Item by accepting status
messages accompanied by Item keys.

All of the nouns capitalized above are represented as PHP
objects. The creation of each produces a unique, type identified, Key
which may be used to access the object in the mySql database.

## Object construction and Instantiation

The objects are built on a Tally factory model. Rather than
maintaining a separate factory the object provides constructor and
tally methods which create and record or directly instantiate
objects for the database.

Constructors take Keys to instantiate specific objects or they can
tally all of the descendant objects when handed a parent. For example
given a Partner Key a tree can be produced containing: a filtered
list of Customers, continuing to a filtered list of Orders perhaps
with specific Items. The technique used accomplishes building these
object trees in memory after a single database trip.

## Database discipline 

For convenience of access and to address concerns of database
independence an object wrapper for the mySql i object interface is
presented. Along with list construction and parameter cleaning methods
the class DboMy returns a consolidated Result object. The pair also
handles exception messaging, SQL statement debug tracking and
microsecond based timing functionality.