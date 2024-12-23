Return-Path: <netfilter-devel+bounces-5561-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 398439FC076
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Dec 2024 17:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889C37A103C
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Dec 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94241FF611;
	Tue, 24 Dec 2024 16:55:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E01D798E;
	Tue, 24 Dec 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735059312; cv=none; b=EUW6rux94ExSftJyK7c2oyJH050FYSxeExRvgjNYC/gbi+Vbx7MBaNaklOSmNlXoH2W4F8pWRwefdXXfnvkYcQxT6tKDn1Zcb1PMFP9je/RRalSs0WsTtL+2UR7z2pJOyJT2Lk2EbapzeOtvZNsGhxZr3H8lYkxuPJD5oTcY+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735059312; c=relaxed/simple;
	bh=Epky/pyePOVD+ED9ZcmR1hxyHbZwTB2LaCd7NJFcPug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DoIt0+7t4hh8nRM/vPpZzqT8WDwv/usPJKOoQTwhT8Zlrw8LZemtA6HbHFlkfA4milQTKtLwJO7n8lnJ4jXgZw+FVfpF0sweydx29u52EDDHoRSf0GuqVJM7OOLTR+NrG+m1SlaaOOhutyn8XhBHjngmctFs32M+IecLeYom0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHgrc3qW6z6K61V;
	Wed, 25 Dec 2024 00:51:12 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id C5C9B140680;
	Wed, 25 Dec 2024 00:55:05 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 24 Dec 2024 19:55:03 +0300
Message-ID: <f6b255c9-5a88-fedd-5d25-dd7d09ddc989@huawei-partners.com>
Date: Tue, 24 Dec 2024 19:55:01 +0300
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/19] landlock: Support socket access-control
Content-Language: ru
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
CC: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	<willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com>
 <20240904104824.1844082-2-ivanov.mikhail1@huawei-partners.com>
 <ea026af8-bc29-709c-7e04-e145d01fd825@huawei-partners.com>
 <Z0DDQKACIRRDRZRE@google.com>
 <36ac2fde-1344-9055-42e2-db849abf02e0@huawei-partners.com>
 <20241127.oophah4Ueboo@digikod.net>
 <eafd855d-2681-8dfd-a2be-9c02fc07050d@huawei-partners.com>
 <20241128.um9voo5Woo3I@digikod.net>
 <af72be74-50c7-d251-5df3-a2c63c73296a@huawei-partners.com>
In-Reply-To: <af72be74-50c7-d251-5df3-a2c63c73296a@huawei-partners.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 12/2/2024 2:32 PM, Mikhail Ivanov wrote:
> On 11/28/2024 11:52 PM, Mickaël Salaün wrote:
>> On Thu, Nov 28, 2024 at 03:01:52PM +0300, Mikhail Ivanov wrote:
>>> On 11/27/2024 9:43 PM, Mickaël Salaün wrote:
>>>> On Mon, Nov 25, 2024 at 02:04:09PM +0300, Mikhail Ivanov wrote:
>>>>> On 11/22/2024 8:45 PM, Günther Noack wrote:
>>>>>> Hello Mikhail,
>>>>>>
>>>>>> sorry for the delayed response;
>>>>>> I am very happy to see activity on this patch set! :)
>>>>>
>>>>> Hello Günther,
>>>>> No problem, thanks a lot for your feedback!
>>>>>
>>>>>>
>>>>>> On Mon, Nov 11, 2024 at 07:29:49PM +0300, Mikhail Ivanov wrote:
>>>>>>> On 9/4/2024 1:48 PM, Mikhail Ivanov wrote:
>>>>>>>> Landlock implements the `LANDLOCK_RULE_NET_PORT` rule type, 
>>>>>>>> which provides
>>>>>>>> fine-grained control of actions for a specific protocol. Any 
>>>>>>>> action or
>>>>>>>> protocol that is not supported by this rule can not be 
>>>>>>>> controlled. As a
>>>>>>>> result, protocols for which fine-grained control is not 
>>>>>>>> supported can be
>>>>>>>> used in a sandboxed system and lead to vulnerabilities or 
>>>>>>>> unexpected
>>>>>>>> behavior.
>>>>>>>>
>>>>>>>> Controlling the protocols used will allow to use only those that 
>>>>>>>> are
>>>>>>>> necessary for the system and/or which have fine-grained Landlock 
>>>>>>>> control
>>>>>>>> through others types of rules (e.g. TCP bind/connect control with
>>>>>>>> `LANDLOCK_RULE_NET_PORT`, UNIX bind control with
>>>>>>>> `LANDLOCK_RULE_PATH_BENEATH`). Consider following examples:
>>>>>>>>
>>>>>>>> * Server may want to use only TCP sockets for which there is 
>>>>>>>> fine-grained
>>>>>>>>       control of bind(2) and connect(2) actions [1].
>>>>>>>> * System that does not need a network or that may want to 
>>>>>>>> disable network
>>>>>>>>       for security reasons (e.g. [2]) can achieve this by 
>>>>>>>> restricting the use
>>>>>>>>       of all possible protocols.
>>>>>>>>
>>>>>>>> This patch implements such control by restricting socket 
>>>>>>>> creation in a
>>>>>>>> sandboxed process.
>>>>>>>>
>>>>>>>> Add `LANDLOCK_RULE_SOCKET` rule type that restricts actions on 
>>>>>>>> sockets.
>>>>>>>> This rule uses values of address family and socket type (Cf. 
>>>>>>>> socket(2))
>>>>>>>> to determine sockets that should be restricted. This is 
>>>>>>>> represented in a
>>>>>>>> landlock_socket_attr struct:
>>>>>>>>
>>>>>>>>       struct landlock_socket_attr {
>>>>>>>>         __u64 allowed_access;
>>>>>>>>         int family; /* same as domain in socket(2) */
>>>>>>>>         int type; /* see socket(2) */
>>>>>>>>       };
>>>>>>>
>>>>>>> Hello! I'd like to consider another approach to define this 
>>>>>>> structure
>>>>>>> before sending the next version of this patchset.
>>>>>>>
>>>>>>> Currently, it has following possible issues:
>>>>>>>
>>>>>>> First of all, there is a lack of protocol granularity. It's 
>>>>>>> impossible
>>>>>>> to (for example) deny creation of ICMP and SCTP sockets and allow 
>>>>>>> TCP
>>>>>>> and UDP. Since the values of address family and socket type do not
>>>>>>> completely define the protocol for the restriction, we may gain
>>>>>>> incomplete control of the network actions. AFAICS, this is 
>>>>>>> limited to
>>>>>>> only a couple of IP protocol cases (e.g. it's impossible to deny 
>>>>>>> SCTP
>>>>>>> and SMC sockets to only allow TCP, deny ICMP and allow UDP).
>>>>>>>
>>>>>>> But one of the main advantages of socket access rights is the 
>>>>>>> ability to
>>>>>>> allow only those protocols for which there is a fine-grained control
>>>>>>> over their actions (TCP bind/connect). It can be inconvenient
>>>>>>> (and unsafe) for SCTP to be unrestricted, while sandboxed process 
>>>>>>> only
>>>>>>> needs TCP sockets.
>>>>>>
>>>>>> That is a good observation which I had missed.
>>>>>>
>>>>>> I agree with your analysis, I also see the main use case of socket()
>>>>>> restrictions in:
>>>>>>
>>>>>>     (a) restricting socket creating altogether
>>>>>>     (b) only permitting socket types for which there is fine 
>>>>>> grained control
>>>>>>
>>>>>> and I also agree that it would be very surprising when the same 
>>>>>> socket types
>>>>>> that provide fine grained control would also open the door for 
>>>>>> unrestricted
>>>>>> access to SMC, SCTP or other protocols.  We should instead strive 
>>>>>> for a
>>>>>> socket() access control with which these additional protocols weren't
>>>>>> accessible.
>>>>>>
>>>>>>
>>>>>>> Adding protocol (Cf. socket(2)) field was considered a bit during 
>>>>>>> the
>>>>>>> initial discussion:
>>>>>>> https://lore.kernel.org/all/CABi2SkVWU=Wxb2y3fP702twyHBD3kVoySPGSz2X22VckvcHeXw@mail.gmail.com/
>>>>>>
>>>>>> So adding "protocol" to the rule attributes would suffice to 
>>>>>> restrict the use of
>>>>>> SMC and SCTP then?  (Sorry, I lost context on these protocols a 
>>>>>> bit in the
>>>>>> meantime, I was so far under the impression that these were using 
>>>>>> different
>>>>>> values for family and type than TCP and UDP do.)
>>>>>
>>>>> Yeap. Following rule will be enough to allow TCP sockets only:
>>>>>
>>>>> const struct landlock_socket_attr create_socket_attr = {
>>>>>     .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>>>     .family = AF_INET{,6},
>>>>>     .type = SOCK_STREAM,
>>>>>     .protocol = 0
>>>>> };
>>>>
>>>> We should indeed include the protocol type in the rule definition.
>>>>
>>>>>
>>>>> Btw, creation of SMC sockets via IP stack was added quite recently.
>>>>> So far, creation has been possible only with AF_SMC family.
>>>>>
>>>>> https://lore.kernel.org/all/1718301630-63692-1-git-send-email-alibuda@linux.alibaba.com/
>>>>>
>>>>>>
>>>>>>
>>>>>>> Secondly, I'm not really sure if socket type granularity is required
>>>>>>> for most of the protocols. It may be more convenient for the end 
>>>>>>> user
>>>>>>> to be able to completely restrict the address family without 
>>>>>>> specifying
>>>>>>> whether restriction is dedicated to stream or dgram sockets (e.g. 
>>>>>>> for
>>>>>>> BLUETOOTH, VSOCK sockets). However, this is not a big issue for the
>>>>>>> current design, since address family can be restricted by specifying
>>>>>>> type = SOCK_TYPE_MASK.
>>>>
>>>> It looks like SOCK_TYPE_MASK is not part of UAPI, which means it could
>>>> change with kernel versions (even while being in UAPI in fact).  This
>>>> new socket creation control should allow to deny any socket creation
>>>> known or unknow at the time of the user space program build, and
>>>> whatever the available C headers.
>>>
>>> Agreed
>>>
>>>>
>>>> This also means that Landlock should accept any domain, type, and
>>>> protocols defined in rules.  Indeed, we don't want to reject rules for
>>>> which some protocols are not allowed.
>>>
>>> Do you mean that Landlock should not make any assumptions about this
>>> values during a build time? Currently, patchset provides boundary checks
>>> for domain (< AF_MAX) and type (< SOCK_MAX) in landlock_add_rule().
>>
>> The *running kernel* may not support some socket's domains or types,
>> which may be confusing for users if the rule was tested on a kernel
>> supporting such domains/types. >
>> For the bitmask of domains or types, the issues to keep boundary checks
>> would be when a subset of them is not supported.  Landlock would reject
>> such rule and it would be difficult for users to identify the cause.
> 
> Ok, I'll remove these checks.
> 
>>
>> I'm still wondering if the landlock_append_net_rule()'s -EAFNOSUPPORT
>> return value for kernels without CONFIG_INET was a good idea.  We should
>> probably return 0 in this case, which would be similar to not checking
>> socket's domains nor types.
> 
> It seems that returning -EAFNOSUPPORT only complicates error checking
> for landlock_append_net_rule() from the user's perspective. Probably the
> only reason to check the correctness of restricted objects in Landlock
> is to provide errors consistency in hooks.
> 
>>
>>>
>>>>
>>>> What about using bitmasks for the domain and type fields (renamed to
>>>> "domains" and "types")?  The last protocol is currently 45/MCTP so a
>>>> 64-bit field is enough, and 10/SOCK_PACKET also fits for the last 
>>>> socket
>>>> type.
>>>>
>>>> We cannot do the same with the protocol because the higher one is
>>>> 262/MPTCP though.  But it looks like a value of 0 (default protocol)
>>>> should be enough for most use cases, and users could specify a protocol
>>>> (but this time as a number, not a bitmask).
>>>>
>>>> To sum up, we could have something like this:
>>>>
>>>>     const struct landlock_socket_attr create_socket_attr = {
>>>>         .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>>         .families = 1 << AF_INET | 1 << AF_INET6,
>>>>         .types = 1 << SOCK_STREAM,
>>>>         .protocol = IPPROTO_SCTP
>>>>     };
>>>
>>> Looks good! I think it's a nice approach which will provide a sufficient
>>> level of flexibility to define a single rule for a specific protocol (or
>>> for related protocols).
>>>
>>> But, this adds possibility to define a single rule for the set of
>>> unrelated protocols:
>>>
>>> /* Allows TCP, UDP and UNIX sockets. */
>>> const struct landlock_socket_attr create_socket_attr = {
>>>     .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>     .families = 1 << AF_INET | 1 << AF_INET6 | 1 << AF_UNIX,
>>>     .types = 1 << SOCK_STREAM | 1 << SOCK_DGRAM,
>>>     .protocol = 0
>>> };
>>>
>>> Perhaps limiting the addition of one rule to only one address family
>>> would be more clear in terms of rule semantics?:
>>>
>>> /* Allows TCP, UDP, UNIX STREAM, UNIX DGRAM sockets. */
>>> const struct landlock_socket_attr create_socket_attrs[] = {
>>>     {
>>>         /* Allows IPv4 TCP and UDP sockets. */
>>>         .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>         .family = AF_INET,
>>>         .types = 1 << SOCK_STREAM | 1 << SOCK_DGRAM,
>>>         .protocol = 0
>>>     },
>>>     {
>>>         /* Allows IPv6 TCP and UDP sockets. */
>>>         .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>         .family = AF_INET6,
>>>         .types = 1 << SOCK_STREAM | 1 << SOCK_DGRAM,
>>>         .protocol = 0
>>>     },
>>>     {
>>>         /* Allows UNIX sockets. */
>>>         .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>         .family = AF_UNIX,
>>>         .types = 1 << SOCK_STREAM | 1 << SOCK_DGRAM,
>>>         .protocol = 0
>>>     },
>>> };
>>
>> Because we are already mixing bitmasks and (protocol) value, I'm not
>> sure it will help much.  I think in most cases the "families" bitmask
>> would handle IPv4 and IPv6 the same (e.g. to only allow TCP with one
>> rule).  I think this is also required to be able to have a 1:1 mapping
>> with SELinux's socket_type_to_security_class().
> 
> Ok, agreed

The bitmask approach leads to a complete refactoring of socket rule
storage. This shouldn't be a big issue, since we're gonna need
multiplexer for insert_rule(), find_rule() with a port range feature
anyway [1]. But it seems that the best approach of storing rules
composed of bitmasks is to store them in linked list and perform
linear scan in landlock_find_rule(). Any other approach is likely to
be too heavy and complex.

Do you think such refactoring is reasonable?

[1] https://github.com/landlock-lsm/linux/issues/16

> 
>>
>>>
>>>>
>>>>
>>>>>>
>>>>>> Whether the user is adding one rule to permit AF_INET+*, or 
>>>>>> whether the user is
>>>>>> adding two rules to permit (1) AF_INET+SOCK_STREAM and (2) 
>>>>>> AF_INET+SOCK_DGRAM,
>>>>>> that does not seem like a big deal to me as long as the list of such
>>>>>> combinations is so low?
>>>>>
>>>>> Agreed
>>>>
>>>> I also agree, but this might change if users have to set a combination
>>>> of families, types, and protocols.  This should be OK with the bitmask
>>>> approach though.
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>> I suggest implementing something close to selinux socket classes 
>>>>>>> for the
>>>>>>> struct landlock_socket_attr (Cf. 
>>>>>>> socket_type_to_security_class()). This
>>>>>>> will provide protocol granularity and may be simpler and more 
>>>>>>> convenient
>>>>>>> in the terms of determining access rights. WDYT?
>>>>>>
>>>>>> I see that this is a longer switch statement that maps to this 
>>>>>> enum, it would be
>>>>>> an additional data table that would have to be documented 
>>>>>> separately for users.
>>>>>
>>>>> This table is the general drawback, since it makes API a bit more
>>>>> complex.
>>>>>
>>>>>>
>>>>>> Do you have an example for how such a "security class enum" would 
>>>>>> map to the
>>>>>> combinations of family, type and socket for the protocols 
>>>>>> discussed above?
>>>>>
>>>>> I think the socket_type_to_security_class() has a pretty good mapping
>>>>> for UNIX and IP families.
>>>>
>>>> The mapping looks good indeed, and it has been tested for a long time
>>>> with many applications.  However, this would make the kernel
>>>> implementation more complex, and I think this mapping could easily be
>>>> implemented in user space libraries with the bitmask approach, if 
>>>> really
>>>> needed, which I'm not sure.
>>>
>>> I agree, implementing this in a library is a better approach. Thanks for
>>> the catch!
>>>
>>>>
>>>>>
>>>>>>
>>>>>> If this is just a matter of actually mapping (family, type, protocol)
>>>>>> combinations in a more flexible way, could we get away by allowing 
>>>>>> a special
>>>>>> "wildcard" value for the "protocol" field, when it is used within 
>>>>>> a ruleset?
>>>>>> Then the LSM would have to look up whether there is a rule for 
>>>>>> (family, type,
>>>>>> protocol) and the only change would be that it now needs to also 
>>>>>> check whether
>>>>>> there is a rule for (family, type, *)?
>>>>>
>>>>> Something like this?
>>>>>
>>>>> const struct landlock_socket_attr create_socket_attr = {
>>>>>     .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
>>>>>     .family = AF_INET6,
>>>>>     .type = SOCK_DGRAM,
>>>>>     .protocol = LANDLOCK_SOCKET_PROTO_ALL
>>>>> };
>>>>>
>>>>>>
>>>>>> —Günther
>>>>>
>>>

