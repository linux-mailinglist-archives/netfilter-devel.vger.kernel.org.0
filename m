Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1983D7424B5
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jun 2023 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjF2LH1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Jun 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjF2LHZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:07:25 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC3710CF
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Jun 2023 04:07:22 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QsFyw29XNzMpntD;
        Thu, 29 Jun 2023 11:07:20 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QsFyv0dyfzMppqW;
        Thu, 29 Jun 2023 13:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1688036840;
        bh=5LBLzyTFEDKOfHzMY3qvsgKAlHJ02xP9+1UNrQQlmxQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=z7iVMzKRvDpVWN71xSjOKCg/UOuegO5Uy4IMXUXtfxHcbdpqfYgK2T5NDXPUEhNTp
         61J0qK1O479C5J3PchwoiArJ9vWcG92sNdbmuCgdoJ7CIMvWyVCPa9Q6CT9AFME6FA
         Kb2MggFdEwNUIajySWpAksB/XpSdJuOYQrDt42gQ=
Message-ID: <b4440d19-93b9-e234-007b-4fc4f987550b@digikod.net>
Date:   Thu, 29 Jun 2023 13:07:18 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v9 00/12] Network support for Landlock - allowed list of
 protocols
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
        "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        willemdebruijn.kernel@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>
References: <20230116085818.165539-1-konstantin.meskhidze@huawei.com>
 <Y/fl5iEbkL5Pj5cJ@galopp> <c20fc9eb-518e-84b4-0dd5-7b97c0825259@huawei.com>
 <3e113e1c-4c7b-af91-14c2-11b6ffb4d3ef@digikod.net>
 <b8a2045a-e7e8-d141-7c01-bf47874c7930@digikod.net>
 <ZJvy2SViorgc+cZI@google.com>
 <CABi2SkX-dzUO6NnbyqfrAg7Bbn+Ne=Xi1qC1XMrzHqVEVucQ0Q@mail.gmail.com>
 <43e8acb2-d696-c001-b54b-d2b7cf244de7@digikod.net>
 <CABi2SkV1Q-cvMScEtcsHbgNRuGc39eJo6KT=GwUxsWPpFGSR4A@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CABi2SkV1Q-cvMScEtcsHbgNRuGc39eJo6KT=GwUxsWPpFGSR4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 29/06/2023 05:18, Jeff Xu wrote:
> resend.
> 
> On Wed, Jun 28, 2023 at 12:29 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>>
>> On 28/06/2023 19:03, Jeff Xu wrote:
>>> Hello,
>>>
>>> Thanks for writing up the example for an incoming TCP connection ! It
>>> helps with the context.
>>>
>>> Since I'm late to this thread, one thing I want to ask:  all the APIs
>>> proposed so far are at the process level, we don't have any API that
>>> applies restriction to socket fd itself, right ? this is what I
>>> thought, but I would like to get confirmation.
>>
>> Restriction are applied to actions, not to already existing/opened FDs.
>> We could add a way to restrict opened FDs, but I don't think this is the
>> right approach because sandboxing is a deliberate action from a process,
>> and it should already take care of its FDs.
>>
>>
>>>
>>> On Wed, Jun 28, 2023 at 2:09 AM Günther Noack <gnoack@google.com> wrote:
>>>>
>>>> Hello!
>>>>
>>>> On Mon, Jun 26, 2023 at 05:29:34PM +0200, Mickaël Salaün wrote:
>>>>> Here is a design to be able to only allow a set of network protocols and
>>>>> deny everything else. This would be complementary to Konstantin's patch
>>>>> series which addresses fine-grained access control.
>>>>>
>>>>> First, I want to remind that Landlock follows an allowed list approach with
>>>>> a set of (growing) supported actions (for compatibility reasons), which is
>>>>> kind of an allow-list-on-a-deny-list. But with this proposal, we want to be
>>>>> able to deny everything, which means: supported, not supported, known and
>>>>> unknown protocols.
>>>>>
>>>>> We could add a new "handled_access_socket" field to the landlock_ruleset
>>>>> struct, which could contain a LANDLOCK_ACCESS_SOCKET_CREATE flag.
>>>>>
>>>>> If this field is set, users could add a new type of rules:
>>>>> struct landlock_socket_attr {
>>>>>       __u64 allowed_access;
>>>>>       int domain; // see socket(2)
>>>>>       int type; // see socket(2)
>>>>> }
>>>>>
>>>>> The allowed_access field would only contain LANDLOCK_ACCESS_SOCKET_CREATE at
>>>>> first, but it could grow with other actions (which cannot be handled with
>>>>> seccomp):
>>>>> - use: walk through all opened FDs and mark them as allowed or denied
>>>>> - receive: hook on received FDs
>>>>> - send: hook on sent FDs
>>>>>
>>>>> We might also use the same approach for non-socket objects that can be
>>>>> identified with some meaningful properties.
>>>>>
>>>>> What do you think?
>>>>
>>>> This sounds like a good plan to me - it would make it possible to restrict new
>>>> socket creation using protocols that were not intended to be used, and I also
>>>> think it would fit the Landlock model nicely.
>>>>
>>>> Small remark on the side: The security_socket_create() hook does not only get
>>>> invoked as a result of socket(2), but also as a part of accept(2) - so this
>>>> approach might already prevent new connections very effectively.
>>>>
>>> That is an interesting aspect that might be worth discussing more.
>>> seccomp is per syscall, landlock doesn't necessarily follow the same,
>>> another design is to add more logic in Landlock, e.g.
>>> LANDLOCK_ACCESS_SOCKET_PROTOCOL which will apply to all of the socket
>>> calls (socket/bind/listen/accept/connect). App dev might feel it is
>>> easier to use.
>>
>> seccomp restricts the use of the syscall interface, whereas Landlock
>> restricts the use of kernel objects (i.e. the semantic).
>>
>> We need to find a good tradeoff between a lot of access rights and a few
>> grouping different actions. This should make sense from a developer
>> point of view according to its knowledge and use of the kernel
>> interfaces (potential wrapped with high level libraries), but also to
>> the semantic of the sandbox and the security guarantees we want to provide.
>>
>> We should also keep in mind that high level Landlock libraries can take
>> care of potential coarse-grained use of restrictions.
>>
>>
>>>
>>>> Spelling out some scenarios, so that we are sure that we are on the same page:
>>>>
>>>> A)
>>>>
>>>> A program that does not need networking could specify a ruleset where
>>>> LANDLOCK_ACCESS_SOCKET_CREATE is handled, and simply not permit anything.
>>>>
>>>> B)
>>>>
>>>> A program that runs a TCP server could specify a ruleset where
>>>> LANDLOCK_NET_BIND_TCP, LANDLOCK_NET_CONNECT_TCP and
>>>> LANDLOCK_ACCESS_SOCKET_CREATE are handled, and where the following rules are added:
>>>>
>>>>     /* From Konstantin's patch set */
>>>>     struct landlock_net_service_attr bind_attr = {
>>>>       .allowed_access = LANDLOCK_NET_BIND_TCP,
>>>>       .port = 8080,
>>>>     };
>>>>
>>>>     /* From Mickaël's proposal */
>>>>     struct landlock_socket_attr sock_inet_attr = {
>>>>       .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>>       .domain = AF_INET,
>>>>       .type = SOCK_STREAM,
>>>>     }
>>>>
>>>>     struct landlock_socket_attr sock_inet6_attr = {
>>>>       .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>>       .domain = AF_INET6,
>>>>        .type = SOCK_STREAM,
>>>>     }
>>>>
>>>> That should then be enough to bind and listen on ports, whereas outgoing
>>>> connections with TCP and anything using other network protocols would not be
>>>> permitted.
>>>>
>>> TCP server is an interesting case. From a security perspective, a
>>> process cares if it is acting as a server or client in TCP, a server
>>> might only want to accept an incoming TCP connection, never initiate
>>> an outgoing TCP connection, and a client is the opposite.
>>>
>>> Processes can restrict outgoing/incoming TCP connection by seccomp for
>>> accept(2) or connect(2),  though I feel Landlock can do this more
>>> naturally for app dev, and at per-protocol level.  seccomp doesn't
>>> provide per-protocol granularity.
>>
>> Right, seccomp cannot filter TCP ports.
>>
>>>
>>> For bind(2), iirc, it can be used for a server to assign dst port of
>>> incoming TCP connection, also by a client to assign a src port of an
>>> outgoing TCP connection. LANDLOCK_NET_BIND_TCP will apply to both
>>> cases, right ? this might not be a problem, just something to keep
>>> note.
>>
>> Good point. I think it is in line with the rule definition: to allow to
>> bind on a specific port. However, if clients want to set the source port
>> to a (legitimate) value, then that would be an issue because we cannot
>> allow a whole range of ports (e.g., >= 1024). I'm not sure if this
>> practice would be deemed "legitimate" though. Do you know client
>> applications using bind?
>>
>> Konstantin, we should have a test for this case anyway.

Thinking more about TCP clients binding sockets, a 
LANDLOCK_ACCESS_NET_LISTEN_TCP would be more useful than 
LANDLOCK_ACCESS_NET_BIND_TCP, but being able to limit the scope of 
"bindable" ports is also valuable to forbid a malicious sandboxed 
process to impersonate a legitimate server process. This also means that 
it might be interesting to be able to handle port ranges.

We already have a LANDLOCK_ACCESS_NET_BIND_TCP implementation and 
related tests, so I think we should proceed with that. The next 
network-related patch series should implement this 
LANDLOCK_ACCESS_NET_LISTEN_TCP access right though, which should not be 
difficult thanks to the framework implemented with current patch series.

Konstantin, would you like to develop the TCP listening access control 
once this patch series land?


>>>> (Alternatively, it could bind() the socket early, *then enable Landlock* and
>>>> leave out the rule for BIND_TCP, only permitting SOCKET_CREATE for IPv4 and
>>>> IPv6, so that listen() and accept() work on the already-bound socket.)
>>>>
>>> For this approach, LANDLOCK_ACCESS_SOCKET_PROTOCOL is a better name,
>>> so dev is fully aware it is not just applied to socket create.
>>
>> I don't get the semantic of LANDLOCK_ACCESS_SOCKET_PROTOCOL. What does
>> PROTOCOL mean?
>>
> I meant checking family + type of socket, and apply to all of
> socket(2),bind(2),accept(2),connect(2),listen(2), maybe
> send(2)/recv(2) too.

OK, that would be kind of similar to the LANDLOCK_ACCESS_SOCKET_USE 
description. However, I think this kind of global approach has several 
issues:
- This covers a lot of different aspects and would increase the cost of 
development/testing/review.
- Whereas it wraps different actions, it will not let user space have a 
fine-grained access control on these, which could be useful for some use 
cases.
- I don't see the point of restricting accept(2) if we can already 
restrict bind(2) and listen(2). accept(2) could be useful to identify 
the remote peer but I'm not convinced this would make sense, and if it 
would, then this can be postponed until we have a way to identify peers.
- For performance reasons, we should avoid restricting 
send/recv/read/write but instead only restrict the control plane: object 
creation and configuration.

I'm not convinced that being able to control all kind of socket bind, 
listen and connect actions might be worth implementing instead of a 
fine-grained access control for the main protocols (TCP, UDP, unix and 
vsock maybe), with the related tests and guarantees.

However, this landlock_socket_attr struct could have an allowed_access 
field that could contain LANDLOCK_ACCESS_NET_{CONNECT,LISTEN,BIND}_TCP 
rights (which would just not be constrained by any port, except if a 
landlock_net_port_attr rule matches). It would then make sense to rename 
LANDLOCK_ACCESS_SOCKET_CREATE to LANDLOCK_ACCESS_NET_CREATE_SOCKET. This 
right would not be accepted in a landlock_net_port_attr.allowed_access 
though.

> 
> s/LANDLOCK_ACCESS_SOCKET_CREATE/LANDLOCK_ACCESS_SOCKET_TYPE.
> 
> This implies the kernel will check on socket fd's property (family +
> type) at those calls, this applies to
> a - the socket fd is created within the process, after landlock is applied.
> b - created in process prior to landlock is applied.
> c - created out of process then passed into this process,

OK, these are the same rules as for LANDLOCK_ACCESS_NET_{CONNECT,BIND}_TCP.
