Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB372DECF
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Jun 2023 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbjFMKNN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Jun 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjFMKNL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:13:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D77186;
        Tue, 13 Jun 2023 03:13:09 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QgPVz2bp9z6J7CN;
        Tue, 13 Jun 2023 18:12:27 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:13:05 +0100
Message-ID: <86108314-de87-5342-e0fb-a07feee457a5@huawei.com>
Date:   Tue, 13 Jun 2023 13:13:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v11 12/12] landlock: Document Landlock's network support
Content-Language: ru
To:     Jeff Xu <jeffxu@chromium.org>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>
CC:     <mic@digikod.net>, <willemdebruijn.kernel@gmail.com>,
        <gnoack3000@gmail.com>, <linux-security-module@vger.kernel.org>,
        <netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-13-konstantin.meskhidze@huawei.com>
 <ZH89Pi1QAqNW2QgG@google.com>
 <CABi2SkWqHeLkmqONbmavcp2SCiwe6YeH_3dkBLZwSsk7neyPMw@mail.gmail.com>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <CABi2SkWqHeLkmqONbmavcp2SCiwe6YeH_3dkBLZwSsk7neyPMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



6/7/2023 8:46 AM, Jeff Xu пишет:
> On Tue, Jun 6, 2023 at 7:09 AM Günther Noack <gnoack@google.com> wrote:
>>
>> On Tue, May 16, 2023 at 12:13:39AM +0800, Konstantin Meskhidze wrote:
>> > Describe network access rules for TCP sockets. Add network access
>> > example in the tutorial. Add kernel configuration support for network.
>> >
>> > Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> > ---
>> >
>> > Changes since v10:
>> > * Fixes documentaion as Mickaёl suggested:
>> > https://lore.kernel.org/linux-security-module/ec23be77-566e-c8fd-179e-f50e025ac2cf@digikod.net/
>> >
>> > Changes since v9:
>> > * Minor refactoring.
>> >
>> > Changes since v8:
>> > * Minor refactoring.
>> >
>> > Changes since v7:
>> > * Fixes documentaion logic errors and typos as Mickaёl suggested:
>> > https://lore.kernel.org/netdev/9f354862-2bc3-39ea-92fd-53803d9bbc21@digikod.net/
>> >
>> > Changes since v6:
>> > * Adds network support documentaion.
>> >
>> > ---
>> >  Documentation/userspace-api/landlock.rst | 83 ++++++++++++++++++------
>> >  1 file changed, 62 insertions(+), 21 deletions(-)
>> >
>> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
>> > index f6a7da21708a..f185dbaa726a 100644
>> > --- a/Documentation/userspace-api/landlock.rst
>> > +++ b/Documentation/userspace-api/landlock.rst
>> > @@ -11,10 +11,10 @@ Landlock: unprivileged access control
>> >  :Date: October 2022
>> >
>> >  The goal of Landlock is to enable to restrict ambient rights (e.g. global
>> > -filesystem access) for a set of processes.  Because Landlock is a stackable
>> > -LSM, it makes possible to create safe security sandboxes as new security layers
>> > -in addition to the existing system-wide access-controls. This kind of sandbox
>> > -is expected to help mitigate the security impact of bugs or
>> > +filesystem or network access) for a set of processes.  Because Landlock
>> > +is a stackable LSM, it makes possible to create safe security sandboxes as new
>> > +security layers in addition to the existing system-wide access-controls. This
>> > +kind of sandbox is expected to help mitigate the security impact of bugs or
>> >  unexpected/malicious behaviors in user space applications.  Landlock empowers
>> >  any process, including unprivileged ones, to securely restrict themselves.
>> >
>> > @@ -28,20 +28,24 @@ appropriately <kernel_support>`.
>> >  Landlock rules
>> >  ==============
>> >
>> > -A Landlock rule describes an action on an object.  An object is currently a
>> > -file hierarchy, and the related filesystem actions are defined with `access
>> > -rights`_.  A set of rules is aggregated in a ruleset, which can then restrict
>> > -the thread enforcing it, and its future children.
>> > +A Landlock rule describes an action on a kernel object.  Filesystem
>> > +objects can be defined with a file hierarchy.  Since the fourth ABI
>> > +version, TCP ports enable to identify inbound or outbound connections.
>> > +Actions on these kernel objects are defined according to `access
>> > +rights`_.  A set of rules is aggregated in a ruleset, which
>> > +can then restrict the thread enforcing it, and its future children.
>>
>> I feel that this paragraph is a bit long-winded to read when the
>> additional networking aspect is added on top as well.  Maybe it would
>> be clearer if we spelled it out in a more structured way, splitting up
>> the filesystem/networking aspects?
>>
>> Suggestion:
>>
>>   A Landlock rule describes an action on an object which the process
>>   intends to perform.  A set of rules is aggregated in a ruleset,
>>   which can then restrict the thread enforcing it, and its future
>>   children.
>>
>>   The two existing types of rules are:
>>
>>   Filesystem rules
>>       For these rules, the object is a file hierarchy,
>>       and the related filesystem actions are defined with
>>       `filesystem access rights`.
>>
>>   Network rules (since ABI v4)
>>       For these rules, the object is currently a TCP port,
> Remote port or local port ?
> 
   Both ports - remote or local.
> 
>>       and the related actions are defined with `network access rights`.
>>
>> Please note that the landlock(7) man page is in large parts using the
>> same phrasing as the kernel documentation.  It might be a good idea to
>> keep them in sync and structured similarly.  (On that mailing list,
>> the reviews are a bit more focused on good writing style.)
>>
>> The same reasoning applies to the example below as well.  Explaining
>> multiple aspects of a thing in a single example can muddy the message,
>> let's try to avoid that.  But I can also see that if we had two
>> separate examples, a large part of the example would be duplicated.
>>
>> >  Defining and enforcing a security policy
>> >  ----------------------------------------
>> >
>> >  We first need to define the ruleset that will contain our rules.  For this
>> > -example, the ruleset will contain rules that only allow read actions, but write
>> > -actions will be denied.  The ruleset then needs to handle both of these kind of
>> > -actions.  This is required for backward and forward compatibility (i.e. the
>> > -kernel and user space may not know each other's supported restrictions), hence
>> > -the need to be explicit about the denied-by-default access rights.
>> > +example, the ruleset will contain rules that only allow filesystem read actions
>> > +and establish a specific TCP connection, but filesystem write actions
>> > +and other TCP actions will be denied.  The ruleset then needs to handle both of
>> > +these kind of actions.  This is required for backward and forward compatibility
>> > +(i.e. the kernel and user space may not know each other's supported
>> > +restrictions), hence the need to be explicit about the denied-by-default access
>> > +rights.
>>
>> I think it became a bit long - I'd suggest to split it into multiple
>> paragraphs, one after "our rules." (in line with landlock(7)), and one
>> after "will be denied."
>>
>> Maybe the long sentence "For this example, ..." in the middle
>> paragraph could also be split up in two, to make it more readable?  I
>> think the point of that sentence is really just to give a brief
>> overview over what ruleset we are setting out to write.
>>
>> >
>> >  .. code-block:: c
>> >
>> > @@ -62,6 +66,9 @@ the need to be explicit about the denied-by-default access rights.
>> >              LANDLOCK_ACCESS_FS_MAKE_SYM |
>> >              LANDLOCK_ACCESS_FS_REFER |
>> >              LANDLOCK_ACCESS_FS_TRUNCATE,
>> > +        .handled_access_net =
>> > +            LANDLOCK_ACCESS_NET_BIND_TCP |
>> > +            LANDLOCK_ACCESS_NET_CONNECT_TCP,
>> >      };
>> >
>> >  Because we may not know on which kernel version an application will be
>> > @@ -70,14 +77,18 @@ should try to protect users as much as possible whatever the kernel they are
>> >  using.  To avoid binary enforcement (i.e. either all security features or
>> >  none), we can leverage a dedicated Landlock command to get the current version
>> >  of the Landlock ABI and adapt the handled accesses.  Let's check if we should
>> > -remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
>> > -access rights, which are only supported starting with the second and third
>> > -version of the ABI.
>> > +remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE`` or
>> > +network access rights, which are only supported starting with the second,
>> > +third and fourth version of the ABI.
>>
>> At some point it becomes too much to spell it out in one sentence; I'd recommend
>>
>>   Let's check if we should remove access rights which are only supported
>>   in higher versions of the ABI.
>>
>> >
>> >  .. code-block:: c
>> >
>> >      int abi;
>> >
>> > +    #define ACCESS_NET_BIND_CONNECT ( \
>> > +        LANDLOCK_ACCESS_NET_BIND_TCP | \
>> > +        LANDLOCK_ACCESS_NET_CONNECT_TCP)
>> > +
>>
>> This #define does not seem to be used? -- Drop it?
>>
>>
>> >      abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
>> >      if (abi < 0) {
>> >          /* Degrades gracefully if Landlock is not handled. */
>> > @@ -92,6 +103,11 @@ version of the ABI.
>> >      case 2:
>> >          /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
>> >          ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>> > +    case 3:
>> > +        /* Removes network support for ABI < 4 */
>> > +        ruleset_attr.handled_access_net &=
>> > +            ~(LANDLOCK_ACCESS_NET_BIND_TCP |
>> > +              LANDLOCK_ACCESS_NET_CONNECT_TCP);
>> >      }
>> >
>> >  This enables to create an inclusive ruleset that will contain our rules.
>> > @@ -143,10 +159,23 @@ for the ruleset creation, by filtering access rights according to the Landlock
>> >  ABI version.  In this example, this is not required because all of the requested
>> >  ``allowed_access`` rights are already available in ABI 1.
>> >
>> > -We now have a ruleset with one rule allowing read access to ``/usr`` while
>> > -denying all other handled accesses for the filesystem.  The next step is to
>> > -restrict the current thread from gaining more privileges (e.g. thanks to a SUID
>> > -binary).
>> > +For network access-control, we can add a set of rules that allow to use a port
>> > +number for a specific action: HTTPS connections.
>> > +
>> > +.. code-block:: c
>> > +
>> > +    struct landlock_net_service_attr net_service = {
>> > +        .allowed_access = NET_CONNECT_TCP,
>> > +        .port = 443,
>> > +    };
>> > +
>> > +    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
>> > +                            &net_service, 0);
>> > +
>> > +The next step is to restrict the current thread from gaining more privileges
>> > +(e.g. through a SUID binary). We now have a ruleset with the first rule allowing
>> > +read access to ``/usr`` while denying all other handled accesses for the filesystem,
>> > +and a second rule allowing HTTPS connections.
>> >
>> >  .. code-block:: c
>> >
>> > @@ -355,7 +384,7 @@ Access rights
>> >  -------------
>> >
>> >  .. kernel-doc:: include/uapi/linux/landlock.h
>> > -    :identifiers: fs_access
>> > +    :identifiers: fs_access net_access
>> >
>> >  Creating a new ruleset
>> >  ----------------------
>> > @@ -374,6 +403,7 @@ Extending a ruleset
>> >
>> >  .. kernel-doc:: include/uapi/linux/landlock.h
>> >      :identifiers: landlock_rule_type landlock_path_beneath_attr
>> > +                  landlock_net_service_attr
>> >
>> >  Enforcing a ruleset
>> >  -------------------
>> > @@ -451,6 +481,12 @@ always allowed when using a kernel that only supports the first or second ABI.
>> >  Starting with the Landlock ABI version 3, it is now possible to securely control
>> >  truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
>> >
>> > +Network support (ABI < 4)
>> > +-------------------------
>> > +
>> > +Starting with the Landlock ABI version 4, it is now possible to restrict TCP
>> > +bind and connect actions to only a set of allowed ports.
>> > +
>> >  .. _kernel_support:
>> >
>> >  Kernel support
>> > @@ -469,6 +505,11 @@ still enable it by adding ``lsm=landlock,[...]`` to
>> >  Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
>> >  configuration.
>> >
>> > +To be able to explicitly allow TCP operations (e.g., adding a network rule with
>> > +``LANDLOCK_ACCESS_NET_TCP_BIND``), the kernel must support TCP (``CONFIG_INET=y``).
>> > +Otherwise, sys_landlock_add_rule() returns an ``EAFNOSUPPORT`` error, which can
>> > +safely be ignored because this kind of TCP operation is already not possible.
>> > +
>> >  Questions and answers
>> >  =====================
>> >
>> > --
>> > 2.25.1
>> >
>>
>> —Günther
>>
>> --
>> Sent using Mutt 🐕 Woof Woof
> .
