## Family Photo Project

In an effort to save the photos currently stored underneath my grandma's bed, I'm making a Rails application that uploads family photos alongside a family tree.

This is primarily to preserve photos, but I would like to include any other family history. I reckon some people might want to just to upload some stories (textual at first, then maybe audio recordings)

### Framework

All of my database relations.

#### Tables

* *Relative*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
first | string |
middle | string | can be nil
maiden | string | can be nil
surname | string |
nickname | string |  can be nil
sex | string | can this be an enum somewhere?
birthday | date |
deathday | date | can be nil

* *Photo*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
taken_on | date |
header | string | can be nil
explanation | string | can be nil
location_id | id | reference to Location instance <br> can be nil

* *Memory*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
author_id | id | reference to Relative
content| text |

* *Location*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
address | string | can be nil
city | string |
state | string | can be nil if country != USA
country | string |

#### Joins

* *DescendantBranch*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
parent_id | id | reference to Relative
child_id | id | reference to Relative

* *MarriageBranch*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
wife_id | id | reference to Relative
husband_id | id | reference to Relative

* *Tagged*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
photo_id | id | reference to Photo
relative_id | id | reference to Relative

### Design
