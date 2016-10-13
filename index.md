---
layout: page
index: 00
---

Possum is the directory and authorization service for the new infrastructure stack, providing:

* Role-based access control for people, machines, and code.
* A REST API.
* Secrets vault.
* Pre-built integrations with popular programming languages and open source infrastructure automation tools.

To use Possum, you write policy files to enumerate and categorize the things in your infrastructure : hosts, images, containers, web services, databases, secrets, users, groups, etc. You also use the policy files to define role relationships, such as the members of each group, and permissions rules, such as which groups and machines can fetch each secret. The Possum server runs on top of the policies and provides HTTP services such as authentication, permission checks, secrets, and public keys. You can also perform dynamic updates to the infrastructure, such as change secret values and enroll new hosts.

# Why use Possum?

## Proven

Possum has been running in production for more than two years, solving real-world problems at companies like Cisco, Box, Puppet Labs, Discovery Communications, Ability Networks, Lookout, and Machine Zone. 

In addition, Possum's cryptography has been professionally audited and verified.

## Simple to Use

You can define your entire infrastructure using only 9 elements: policy, user, group, host, layer, variable, web service, role grant, and permission grant. And with just 5 REST functions you can authenticate, search, fetch secrets, perform permission checks, and fetch public keys.

Policies are defined using YAML, which is easy for both people and machines to read and understand. 

## Powerful

Possum provides full role-based access control, which is a proven model for infrastructure security. Unlike attribute-based access control, role-based access control is not susceptible to unexpected side-effects, and it scales very well to large systems through the use of role delegation. 

## Easy to deploy and operate

Running Possum is as simple as `docker-compose up`. The default backing data store for Possum is Postgresql. You can run the database alongside Possum as a Docker container, or you can use a hosted database service such as AWS RDS.

## Flexible

You can use Possum to solve many different problems. For example:

* Providing SSL certificates to internal and external servers.
* Securely enrolling new machines into an environment.
* Authorizing web service traffic between services.
* Listing all the machines and containers in an environment, along with their roles.
* Managing and distributing public keys.
* Distributing database passwords (and other types of credentials) to applications and services.
* Providing authorization logic for configuration management and container orchestration.

## Programmable

Possum is easily programmable by interacting with the REST API. This capability can be used to provide custom authentication and authorization for popular DevOps tools.
