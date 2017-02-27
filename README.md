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
bio | string | can be nil

* *Photo*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
taken_on | date |
uploaded_by | id | reference to Relative
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

* *User*

For keeping track of those who use the application.

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
username | string | assigned by me
password | string | assigned by me
relative_id | id | assigned by user on first login

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
start_date | date |
end_date | date| can be nil

* *PhotoTag*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
photo_id | id | reference to Photo
relative_id | id | reference to Relative

### Design

#### *UX*

I need a login, but we'll get there later. It'll need a user name and password (I might assign those to people, give the limited size of my audience. It'll probably be easier that way).

It will also need a third login parameter-- a 'house.' This way if someone wants to have more than one tree, they can.Then, they are brought to the home page of the house? I could add a 'house_id' attribute to everything, but that seems like a bad idea. I don't want to have multiple database tables, so maybe a 'house_id' attribute isn't the worst idea. And i can assign them as well. Eh, that seems a bit much for now. I will add houses at a later date ([issue here](https://github.com/weathertopper/family-photo-project/issues/17)).

Anyways, people log in. If they haven't logged in before, they will need to setup their profile. There won't be much for a profile. In reality, Start Up with be straight forward...

1. If this user hasn't logged in before, send him/her to the new Relative view (or a clone of it).

2. When 'Create' is pressed (and the user's 'relative_id' is nil), do the usual "is this a duplicate" check.

3. If there is no duplicate, create the relative and set its id as the user's 'relative_id.'

4. If there is a duplicate, go the usual route- throw some alert saying "hey, is this a duplicate of Relative <relative here>?" If so, offer its id as the user's 'relative_id.' Else, step 3.    

Then, they are brought to the home page of the family tree. I reckon that will be the 'index' for the Relative table. From there, every (connected) relative is visible (and clickable). Pinned to the page are links to the Relative 'new' page, the MarriageBranch 'new' page, the DescendantBranch 'new' page, and the Photo 'new' page.

Clicking a Relative directs to the Relative's 'show' page. It will show a larger profile picture (if included), all of the Relative's info, all Memories recorded by the Relative, and the Photos posted by the Relative. Also, one can edit that Relative, add a new MarriageBranch (if that Relative isn't currently married), add a parent (if that Relative has <2 parents), or add a child. There will also be a button to see Photos including the Relative. << That will probably be a separate Photo view based on a PhotoTag filter.

From the Relative's 'index' page, there will also be a link to the index for uploaded pictures (most recent to least recent). From the 'show' of an individual picture, there will be a link to edit and make PhotoTags. There should also be a button that allows for PhotoTag filtering (by date, Relative(s), Photo.uploaded_by, Location, etc).

I reckon that's the bulk of it. 

#### Layout
(I'm obviously not a designer)
