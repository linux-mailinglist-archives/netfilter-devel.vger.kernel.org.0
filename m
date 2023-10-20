Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88A7D0F44
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Oct 2023 13:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377175AbjJTL6n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Oct 2023 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTL6m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:58:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CEA1BF;
        Fri, 20 Oct 2023 04:58:35 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SBjlC1DsDz688JN;
        Fri, 20 Oct 2023 19:57:59 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 12:58:32 +0100
Message-ID: <ae62c363-e9bf-3ab8-991a-0902b0d195cb@huawei.com>
Date:   Fri, 20 Oct 2023 14:58:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v13 08/12] landlock: Add network rules and TCP hooks
 support
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
 <20231016015030.1684504-9-konstantin.meskhidze@huawei.com>
 <20231017.xahKoo9Koo8v@digikod.net>
 <57f150b2-0920-8567-8351-1bdb74684cfa@huawei.com>
 <20231020.ido6Aih0eiGh@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <20231020.ido6Aih0eiGh@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



10/20/2023 12:49 PM, Mickaël Salaün пишет:
> On Fri, Oct 20, 2023 at 07:08:33AM +0300, Konstantin Meskhidze (A) wrote:
>> 
>> 
>> 10/18/2023 3:29 PM, Mickaël Salaün пишет:
>> > On Mon, Oct 16, 2023 at 09:50:26AM +0800, Konstantin Meskhidze wrote:
>> > > This commit adds network rules support in the ruleset management
>> > 
>> > Here are some advices to better write commit messages:
>> > https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>> > The "Describe your changes in imperative mood" part is important for
>> > this commit and others. Most of this patch series' commit messages need
>> > small updates.
>> 
>>  Ok. I will refactor commit messages with "imperative mood". Thanks.
>> > 
>> > > helpers and the landlock_create_ruleset syscall.
>> > > Refactor user space API to support network actions. Add new network
>> > > access flags, network rule and network attributes. Increment Landlock
>> > > ABI version. Expand access_masks_t to u32 to be sure network access
>> > 
>> > Please explain the "why" (when it makes sense) instead of just listing
>> > the "what".
>> 
>>   Ok.
>> 
>> > 
>> > > rights can be stored. Implement socket_bind() and socket_connect()
>> > > LSM hooks, which enables to restrict TCP socket binding and connection
>> > > to specific ports.
>> > 
>> > I reworded and moved this part in last:
>> > > For the file system, a file descriptor is a direct access to a file/data.
>> > > But for the network, it's impossible to identify for which data/peer a
>> > > newly created socket will give access to, it's needed to wait for a
>> > > connect or bind request to identify the use case for this socket.
>> > > That's why the access rights (related to ports) are tied to an opened
>> > > socket, but this would not align with the way Landlock access control
>> > > works for the filesystem [2].
>> 
>>    Thanks.
>> > 
>> > Please add empty line to split paragraphs.
>> 
>>   Got it.
>> > 
>> > > The new landlock_net_port_attr structure has two fields. The allowed_access
>> > > field contains the LANDLOCK_ACCESS_NET_* rights. The port field contains
>> > > the port value according to the allowed protocol. This field can
>> > > take up to a 64-bit value [1] but the maximum value depends on the related
>> > > protocol (e.g. 16-bit for TCP).
>> > 
>> > For the file system, a file descriptor is a direct access to a file/data.
>> > However, for network sockets, we cannot identify for which data or peer a newly
>> > created socket will give access to. Indeed, we need to wait for a connect or
>> > bind request to identify the use case for this socket.
>> > 
>> > Access rights are not tied to socket file descriptors. Instead, bind and
>> > connect actions are controlled by the task's domain.  As for the filesystem, a
>> > directory file descriptor may enable to open another file (i.e. a new data
>> > item), but this opening is restricted by the task's domain, not the file
>> > descriptor's access rights [2].
>> > 
>> > > 
>> > > [1]
>> > > https://lore.kernel.org/r/278ab07f-7583-a4e0-3d37-1bacd091531d@digikod.net
>> > > [2]
>> > > https://lore.kernel.org/all/263c1eb3-602f-57fe-8450-3f138581bee7@digikod.net
>> > 
>> > [1] https://lore.kernel.org/r/278ab07f-7583-a4e0-3d37-1bacd091531d@digikod.net
>> > [2] https://lore.kernel.org/r/263c1eb3-602f-57fe-8450-3f138581bee7@digikod.net
>>   Thanks.
>> > 
>> > > 
>> > > Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> > > Link: https://lore.kernel.org/r/20230920092641.832134-9-konstantin.meskhidze@huawei.com
>> > > [mic: Remove !ARCH_EPHEMERAL_INODES in Kconfig, and add landlock_ prefix
>> > > to add_rule_net_service()]
>> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> > > ---
>> > > 
>> > > Changes since v12:
>> > > * Moves add_rule_net_port() back in syscalls.c and makes it static.
>> > > * Deletes bind_access_mask allowing bind action rule on port 0.
>> > > * Adds comment about port 0 in landlock_net_port_attr structure.
>> > > * Removes !ARCH_EPHEMERAL_INODES from Kconfig.
>> > > * Minor fixes.
>> > > * Refactors commit message.
>> > > 
>> > > Changes since v11:
>> > > * Replaces dates with "2022-2023" in net.c/h files headers.
>> > > * Removes WARN_ON_ONCE(!domain) in check_socket_access().
>> > > * Using "typeof(*address)" instead of offsetofend(struct sockaddr, sa_family).
>> > > * Renames LANDLOCK_RULE_NET_SERVICE to LANDLOCK_RULE_NET_PORT.
>> > > * Renames landlock_net_service_attr to landlock_net_port_attr.
>> > > * Defines two add_rule_net_service() functions according to
>> > >   IS_ENABLED(CONFIG_INET) instead of changing the body of the only
>> > >   function.
>> > > * Adds af_family consistency check while handling AF_UNSPEC specifically.
>> > > * Adds bind_access_mask in add_rule_net_service() to deny all rules with bind
>> > >   action on port zero.
>> > > * Minor fixes.
>> > > * Refactors commit message.
>> > > 
>> > > Changes since v10:
>> > > * Removes "packed" attribute.
>> > > * Applies Mickaёl's patch with some refactoring.
>> > > * Deletes get_port() and check_addrlen() helpers.
>> > > * Refactors check_socket_access() by squashing get_port() and
>> > >   check_addrlen() helpers into it.
>> > > * Fixes commit message.
>> > > 
>> > > Changes since v9:
>> > > * Changes UAPI port field to __u64.
>> > > * Moves shared code into check_socket_access().
>> > > * Adds get_raw_handled_net_accesses() and
>> > >   get_current_net_domain() helpers.
>> > > * Minor fixes.
>> > > 
>> > > Changes since v8:
>> > > * Squashes commits.
>> > > * Refactors commit message.
>> > > * Changes UAPI port field to __be16.
>> > > * Changes logic of bind/connect hooks with AF_UNSPEC families.
>> > > * Adds address length checking.
>> > > * Minor fixes.
>> > > 
>> > > Changes since v7:
>> > > * Squashes commits.
>> > > * Increments ABI version to 4.
>> > > * Refactors commit message.
>> > > * Minor fixes.
>> > > 
>> > > Changes since v6:
>> > > * Renames landlock_set_net_access_mask() to landlock_add_net_access_mask()
>> > >   because it OR values.
>> > > * Makes landlock_add_net_access_mask() more resilient incorrect values.
>> > > * Refactors landlock_get_net_access_mask().
>> > > * Renames LANDLOCK_MASK_SHIFT_NET to LANDLOCK_SHIFT_ACCESS_NET and use
>> > >   LANDLOCK_NUM_ACCESS_FS as value.
>> > > * Updates access_masks_t to u32 to support network access actions.
>> > > * Refactors landlock internal functions to support network actions with
>> > >   landlock_key/key_type/id types.
>> > > 
>> > > Changes since v5:
>> > > * Gets rid of partial revert from landlock_add_rule
>> > > syscall.
>> > > * Formats code with clang-format-14.
>> > > 
>> > > Changes since v4:
>> > > * Refactors landlock_create_ruleset() - splits ruleset and
>> > > masks checks.
>> > > * Refactors landlock_create_ruleset() and landlock mask
>> > > setters/getters to support two rule types.
>> > > * Refactors landlock_add_rule syscall add_rule_path_beneath
>> > > function by factoring out get_ruleset_from_fd() and
>> > > landlock_put_ruleset().
>> > > 
>> > > Changes since v3:
>> > > * Splits commit.
>> > > * Adds network rule support for internal landlock functions.
>> > > * Adds set_mask and get_mask for network.
>> > > * Adds rb_root root_net_port.
>> > > 
>> > > ---
>> > >  include/uapi/linux/landlock.h                |  56 ++++++
>> > >  security/landlock/Kconfig                    |   1 +
>> > >  security/landlock/Makefile                   |   2 +
>> > >  security/landlock/limits.h                   |   5 +
>> > >  security/landlock/net.c                      | 198 +++++++++++++++++++
>> > >  security/landlock/net.h                      |  33 ++++
>> > >  security/landlock/ruleset.c                  |  62 +++++-
>> > >  security/landlock/ruleset.h                  |  59 +++++-
>> > >  security/landlock/setup.c                    |   2 +
>> > >  security/landlock/syscalls.c                 |  69 ++++++-
>> > >  tools/testing/selftests/landlock/base_test.c |   2 +-
>> > >  11 files changed, 466 insertions(+), 23 deletions(-)
>> > >  create mode 100644 security/landlock/net.c
>> > >  create mode 100644 security/landlock/net.h
>> > > 
>> > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>> > > index 81d09ef9aa50..25349666b19e 100644
>> > > --- a/include/uapi/linux/landlock.h
>> > > +++ b/include/uapi/linux/landlock.h
>> > > @@ -31,6 +31,12 @@ struct landlock_ruleset_attr {
>> > >  	 * this access right.
>> > >  	 */
>> > >  	__u64 handled_access_fs;
>> > > +	/**
>> > > +	 * @handled_access_net: Bitmask of actions (cf. `Network flags`_)
>> > > +	 * that is handled by this ruleset and should then be forbidden if no
>> > > +	 * rule explicitly allow them.
>> > > +	 */
>> > > +	__u64 handled_access_net;
>> > >  };
>> > > 
>> > >  /*
>> > > @@ -54,6 +60,11 @@ enum landlock_rule_type {
>> > >  	 * landlock_path_beneath_attr .
>> > >  	 */
>> > >  	LANDLOCK_RULE_PATH_BENEATH = 1,
>> > > +	/**
>> > > +	 * @LANDLOCK_RULE_NET_PORT: Type of a &struct
>> > > +	 * landlock_net_port_attr .
>> > > +	 */
>> > > +	LANDLOCK_RULE_NET_PORT = 2,
>> > 
>> > We don't need the explicit " = 2".
>> 
>>   Fixed. Thanks.
>> > 
>> > >  };
>> > > 
>> > >  /**
>> > > @@ -79,6 +90,32 @@ struct landlock_path_beneath_attr {
>> > >  	 */
>> > >  } __attribute__((packed));
>> > > 
>> > > +/**
>> > > + * struct landlock_net_port_attr - Network port definition
>> > > + *
>> > > + * Argument of sys_landlock_add_rule().
>> > > + */
>> > > +struct landlock_net_port_attr {
>> > > +	/**
>> > > +	 * @allowed_access: Bitmask of allowed access network for a port
>> > > +	 * (cf. `Network flags`_).
>> > > +	 */
>> > > +	__u64 allowed_access;
>> > > +	/**
>> > > +	 * @port: Network port. Landlock does not forbid rules with port 0,
>> > > +	 * since some network services use it. Port 0 is a reserved one in
>> > > +	 * TCP/IP networking, meaning that it should not be used in TCP or
>> > > +	 * UDP messages. To allocate its source port number, services call
>> > > +	 * TCP/IP network functions like bind() to request one. With port 0
>> > > +	 * it triggers the operating system to automatically search for
>> > > +	 * and return a suitable available port in the TCP/IP dynamic
>> > > +	 * port number range. This port range can be controlled by a
>> > > +	 * sysadmin with /proc/sys/net/ipv4/ip_local_port_range sysctl,
>> > > +	 * which is also used by IPv6.
>> > 
>> > This looks too inspired from
>> > https://www.lifewire.com/port-0-in-tcp-and-udp-818145
>> 
>>   Yep. You are right.
>> > 
>> > Let's make it simpler:
>> > 
>> >   * @port: Network port.
>> >   *
>> >   * It should be noted that port 0 passed to :manpage:`bind(2)` will
>> >   * bind to an available port from a specific port range. This can be
>> >   * configured thanks to the ``/proc/sys/net/ipv4/ip_local_port_range``
>> >   * sysctl (also used for IPv6). A Landlock rule with port 0 and the
>> >   * ``LANDLOCK_ACCESS_NET_BIND_TCP`` right means that requesting to bind
>> >   * on port 0 is allowed and it will automatically translate to binding
>> >   * on the related port range.
>>     Thanks.
>> > 
>> > > +	 */
>> > > +	__u64 port;
>> > > +};
>> > > +
>> > >  /**
>> > >   * DOC: fs_access
>> > >   *
>> > > @@ -189,4 +226,23 @@ struct landlock_path_beneath_attr {
>> > >  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>> > >  /* clang-format on */
>> > > 
>> > > +/**
>> > > + * DOC: net_access
>> > > + *
>> > > + * Network flags
>> > > + * ~~~~~~~~~~~~~~~~
>> > > + *
>> > > + * These flags enable to restrict a sandboxed process to a set of network
>> > > + * actions.
>> > 
>> > You can add:
>> > "This is supported since ABI 4."
>> 
>>    Updated.
>> > 
>> > > + *
>> > > + * TCP sockets with allowed actions:
>> > > + *
>> > > + * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
>> > > + * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to
>> > > + *   a remote port.
>> > > + */
>> > > +/* clang-format off */
>> > > +#define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>> > > +#define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>> > > +/* clang-format on */
>> > >  #endif /* _UAPI_LINUX_LANDLOCK_H */
>> > > diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
>> > > index c1e862a38410..c4bf0d5eff39 100644
>> > > --- a/security/landlock/Kconfig
>> > > +++ b/security/landlock/Kconfig
>> > > @@ -3,6 +3,7 @@
>> > >  config SECURITY_LANDLOCK
>> > >  	bool "Landlock support"
>> > >  	depends on SECURITY
>> > > +	select SECURITY_NETWORK
>> > >  	select SECURITY_PATH
>> > >  	help
>> > >  	  Landlock is a sandboxing mechanism that enables processes to restrict
>> > > diff --git a/security/landlock/Makefile b/security/landlock/Makefile
>> > > index 7bbd2f413b3e..53d3c92ae22e 100644
>> > > --- a/security/landlock/Makefile
>> > > +++ b/security/landlock/Makefile
>> > > @@ -2,3 +2,5 @@ obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
>> > > 
>> > >  landlock-y := setup.o syscalls.o object.o ruleset.o \
>> > >  	cred.o ptrace.o fs.o
>> > > +
>> > > +landlock-$(CONFIG_INET) += net.o
>> > > \ No newline at end of file
>> > > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
>> > > index bafb3b8dc677..93c9c6f91556 100644
>> > > --- a/security/landlock/limits.h
>> > > +++ b/security/landlock/limits.h
>> > > @@ -23,6 +23,11 @@
>> > >  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>> > >  #define LANDLOCK_SHIFT_ACCESS_FS	0
>> > > 
>> > > +#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
>> > > +#define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>> > > +#define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>> > > +#define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
>> > > +
>> > >  /* clang-format on */
>> > > 
>> > >  #endif /* _SECURITY_LANDLOCK_LIMITS_H */
>> > > diff --git a/security/landlock/net.c b/security/landlock/net.c
>> > > new file mode 100644
>> > > index 000000000000..1bf26cf3c41b
>> > > --- /dev/null
>> > > +++ b/security/landlock/net.c
>> > > @@ -0,0 +1,198 @@
>> > > +// SPDX-License-Identifier: GPL-2.0-only
>> > > +/*
>> > > + * Landlock LSM - Network management and hooks
>> > > + *
>> > > + * Copyright © 2022-2023 Huawei Tech. Co., Ltd.
>> > > + * Copyright © 2022-2023 Microsoft Corporation
>> > > + */
>> > > +
>> > > +#include <linux/in.h>
>> > > +#include <linux/net.h>
>> > > +#include <linux/socket.h>
>> > > +#include <net/ipv6.h>
>> > > +
>> > > +#include "common.h"
>> > > +#include "cred.h"
>> > > +#include "limits.h"
>> > > +#include "net.h"
>> > > +#include "ruleset.h"
>> > > +
>> > > +int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
>> > > +			     const u16 port, access_mask_t access_rights)
>> > > +{
>> > > +	int err;
>> > > +	const struct landlock_id id = {
>> > > +		.key.data = (__force uintptr_t)htons(port),
>> > > +		.type = LANDLOCK_KEY_NET_PORT,
>> > > +	};
>> > > +
>> > > +	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
>> > > +
>> > > +	/* Transforms relative access rights to absolute ones. */
>> > > +	access_rights |= LANDLOCK_MASK_ACCESS_NET &
>> > > +			 ~landlock_get_net_access_mask(ruleset, 0);
>> > > +
>> > > +	mutex_lock(&ruleset->lock);
>> > > +	err = landlock_insert_rule(ruleset, id, access_rights);
>> > > +	mutex_unlock(&ruleset->lock);
>> > > +
>> > > +	return err;
>> > > +}
>> > > +
>> > > +static access_mask_t
>> > > +get_raw_handled_net_accesses(const struct landlock_ruleset *const domain)
>> > > +{
>> > > +	access_mask_t access_dom = 0;
>> > > +	size_t layer_level;
>> > > +
>> > > +	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
>> > > +		access_dom |= landlock_get_net_access_mask(domain, layer_level);
>> > > +	return access_dom;
>> > > +}
>> > > +
>> > > +static const struct landlock_ruleset *get_current_net_domain(void)
>> > > +{
>> > > +	const struct landlock_ruleset *const dom =
>> > > +		landlock_get_current_domain();
>> > > +
>> > > +	if (!dom || !get_raw_handled_net_accesses(dom))
>> > > +		return NULL;
>> > > +
>> > > +	return dom;
>> > > +}
>> > > +
>> > > +static int check_socket_access(struct socket *const sock,
>> > 
>> > To be consistent with current_check_access_path(), please rename to
>> > current_check_access_socket().
>> 
>>   Done. Thanks.
>> > 
>> > > +			       struct sockaddr *const address,
>> > > +			       const int addrlen,
>> > > +			       const access_mask_t access_request)
>> > > +{
>> > > +	__be16 port;
>> > > +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
>> > > +	const struct landlock_rule *rule;
>> > > +	access_mask_t handled_access;
>> > > +	struct landlock_id id = {
>> > > +		.type = LANDLOCK_KEY_NET_PORT,
>> > > +	};
>> > > +	const struct landlock_ruleset *const domain = get_current_net_domain();
>> > 
>> > For consistency with other functions, s/domain/dom/g
>> 
>>  Ok. Fixed.
>> > 
>> > > +
>> > > +	if (!domain)
>> > > +		return 0;
>> > > +	if (WARN_ON_ONCE(domain->num_layers < 1))
>> > > +		return -EACCES;
>> > > +
>> > > +	/* Checks if it's a (potential) TCP socket. */
>> > > +	if (sock->type != SOCK_STREAM)
>> > > +		return 0;
>> > > +
>> > > +	/* Checks for minimal header length to safely read sa_family. */
>> > > +	if (addrlen < offsetofend(typeof(*address), sa_family))
>> > > +		return -EINVAL;
>> > > +
>> > > +	switch (address->sa_family) {
>> > > +	case AF_UNSPEC:
>> > > +	case AF_INET:
>> > > +		if (addrlen < sizeof(struct sockaddr_in))
>> > > +			return -EINVAL;
>> > > +		port = ((struct sockaddr_in *)address)->sin_port;
>> > > +		break;
>> > > +#if IS_ENABLED(CONFIG_IPV6)
>> > > +	case AF_INET6:
>> > > +		if (addrlen < SIN6_LEN_RFC2133)
>> > > +			return -EINVAL;
>> > > +		port = ((struct sockaddr_in6 *)address)->sin6_port;
>> > > +		break;
>> > > +#endif
>> > 
>> > #endif /* IS_ENABLED(CONFIG_INET) */
>> 
>>   #endif /* IS_ENABLED(CONFIG_IPV6) */ I suppose.
> 
> Indeed
> 
>> > 
>> > > +	default:
>> > > +		return 0;
>> > > +	}
>> > > +
>> > > +	/* Specific AF_UNSPEC handling. */
>> > > +	if (address->sa_family == AF_UNSPEC) {
>> > > +		/*
>> > > +		 * Connecting to an address with AF_UNSPEC dissolves the TCP
>> > > +		 * association, which have the same effect as closing the
>> > > +		 * connection while retaining the socket object (i.e., the file
>> > > +		 * descriptor).  As for dropping privileges, closing
>> > > +		 * connections is always allowed.
>> > > +		 *
>> > > +		 * For a TCP access control system, this request is legitimate.
>> > > +		 * Let the network stack handle potential inconsistencies and
>> > > +		 * return -EINVAL if needed.
>> > > +		 */
>> > > +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP)
>> > > +			return 0;
>> > > +
>> > > +		/*
>> > > +		 * For compatibility reason, accept AF_UNSPEC for bind
>> > > +		 * accesses (mapped to AF_INET) only if the address is
>> > > +		 * INADDR_ANY (cf. __inet_bind).  Checking the address is
>> > > +		 * required to not wrongfully return -EACCES instead of
>> > > +		 * -EAFNOSUPPORT.
>> > > +		 *
>> > > +		 * We could return 0 and let the network stack handle these
>> > > +		 * checks, but it is safer to return a proper error and test
>> > > +		 * consistency thanks to kselftest.
>> > > +		 */
>> > > +		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
>> > > +			/* addrlen has already been checked for AF_UNSPEC. */
>> > > +			const struct sockaddr_in *const sockaddr =
>> > > +				(struct sockaddr_in *)address;
>> > > +
>> > > +			if (sock->sk->__sk_common.skc_family != AF_INET)
>> > > +				return -EINVAL;
>> > > +
>> > > +			if (sockaddr->sin_addr.s_addr != htonl(INADDR_ANY))
>> > > +				return -EAFNOSUPPORT;
>> > > +		}
>> > > +	} else {
>> > > +		/*
>> > > +		 * Checks sa_family consistency to not wrongfully return
>> > > +		 * -EACCES instead of -EINVAL.  Valid sa_family changes are
>> > > +		 * only (from AF_INET or AF_INET6) to AF_UNSPEC.
>> > > +		 *
>> > > +		 * We could return 0 and let the network stack handle this
>> > > +		 * check, but it is safer to return a proper error and test
>> > > +		 * consistency thanks to kselftest.
>> > > +		 */
>> > > +		if (address->sa_family != sock->sk->__sk_common.skc_family)
>> > > +			return -EINVAL;
>> > > +	}
>> > > +
>> > > +	id.key.data = (__force uintptr_t)port;
>> > > +	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
>> > > +
>> > > +	rule = landlock_find_rule(domain, id);
>> > > +	handled_access = landlock_init_layer_masks(
>> > > +		domain, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
>> > > +	if (landlock_unmask_layers(rule, handled_access, &layer_masks,
>> > > +				   ARRAY_SIZE(layer_masks)))
>> > > +		return 0;
>> > > +
>> > > +	return -EACCES;
>> > > +}
>> > > +
>> > > +static int hook_socket_bind(struct socket *const sock,
>> > > +			    struct sockaddr *const address, const int addrlen)
>> > > +{
>> > > +	return check_socket_access(sock, address, addrlen,
>> > > +				   LANDLOCK_ACCESS_NET_BIND_TCP);
>> > > +}
>> > > +
>> > > +static int hook_socket_connect(struct socket *const sock,
>> > > +			       struct sockaddr *const address,
>> > > +			       const int addrlen)
>> > > +{
>> > > +	return check_socket_access(sock, address, addrlen,
>> > > +				   LANDLOCK_ACCESS_NET_CONNECT_TCP);
>> > > +}
>> > > +
>> > > +static struct security_hook_list landlock_hooks[] __ro_after_init = {
>> > > +	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
>> > > +	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
>> > > +};
>> > > +
>> > > +__init void landlock_add_net_hooks(void)
>> > > +{
>> > > +	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
>> > > +			   LANDLOCK_NAME);
>> > > +}
>> > > diff --git a/security/landlock/net.h b/security/landlock/net.h
>> > > new file mode 100644
>> > > index 000000000000..588a49fd6907
>> > > --- /dev/null
>> > > +++ b/security/landlock/net.h
>> > > @@ -0,0 +1,33 @@
>> > > +/* SPDX-License-Identifier: GPL-2.0-only */
>> > > +/*
>> > > + * Landlock LSM - Network management and hooks
>> > > + *
>> > > + * Copyright © 2022-2023 Huawei Tech. Co., Ltd.
>> > > + */
>> > > +
>> > > +#ifndef _SECURITY_LANDLOCK_NET_H
>> > > +#define _SECURITY_LANDLOCK_NET_H
>> > > +
>> > > +#include "common.h"
>> > > +#include "ruleset.h"
>> > > +#include "setup.h"
>> > > +
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +__init void landlock_add_net_hooks(void);
>> > > +
>> > > +int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
>> > > +			     const u16 port, access_mask_t access_rights);
>> > > +#else /* IS_ENABLED(CONFIG_INET) */
>> > > +static inline void landlock_add_net_hooks(void)
>> > > +{
>> > > +}
>> > > +
>> > > +static inline int
>> > > +landlock_append_net_rule(struct landlock_ruleset *const ruleset, const u16 port,
>> > > +			 access_mask_t access_rights);
>> > > +{
>> > > +	return -EAFNOSUPPORT;
>> > > +}
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > > +#endif /* _SECURITY_LANDLOCK_NET_H */
>> > > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
>> > > index 4c209acee01e..1fe4298ff4a7 100644
>> > > --- a/security/landlock/ruleset.c
>> > > +++ b/security/landlock/ruleset.c
>> > > @@ -36,6 +36,11 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>> > >  	refcount_set(&new_ruleset->usage, 1);
>> > >  	mutex_init(&new_ruleset->lock);
>> > >  	new_ruleset->root_inode = RB_ROOT;
>> > > +
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +	new_ruleset->root_net_port = RB_ROOT;
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > >  	new_ruleset->num_layers = num_layers;
>> > >  	/*
>> > >  	 * hierarchy = NULL
>> > > @@ -46,16 +51,21 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>> > >  }
>> > > 
>> > >  struct landlock_ruleset *
>> > > -landlock_create_ruleset(const access_mask_t fs_access_mask)
>> > > +landlock_create_ruleset(const access_mask_t fs_access_mask,
>> > > +			const access_mask_t net_access_mask)
>> > >  {
>> > >  	struct landlock_ruleset *new_ruleset;
>> > > 
>> > >  	/* Informs about useless ruleset. */
>> > > -	if (!fs_access_mask)
>> > > +	if (!fs_access_mask && !net_access_mask)
>> > >  		return ERR_PTR(-ENOMSG);
>> > >  	new_ruleset = create_ruleset(1);
>> > > -	if (!IS_ERR(new_ruleset))
>> > > +	if (IS_ERR(new_ruleset))
>> > > +		return new_ruleset;
>> > > +	if (fs_access_mask)
>> > >  		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
>> > > +	if (net_access_mask)
>> > > +		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
>> > 
>> > This is good, but it is not tested: we need to add a test that both
>> > handle FS and net restrictions. You can add one in net.c, just handling
>> > LANDLOCK_ACCESS_FS_READ_DIR and LANDLOCK_ACCESS_NET_BIND_TCP, add one
>> > rule with path_beneath (e.g. /dev) and another with net_port, and check
>> > that open("/") is denied, open("/dev") is allowed, and and only the
>> > allowed port is allowed with bind(). This test should be simple and can
>> > only check against an IPv4 socket, i.e. using ipv4_tcp fixture, just
>> > after port_endianness. fcntl.h should then be included by net.c
>> 
>>   Ok.
>> > 
>> > I guess that was the purpose of layout1.with_net (in fs_test.c) but it
>> 
>>   Yep. I added this kind of nest in fs_test.c to test both fs and network
>> rules together.
>> > is not complete. You can revamp this test and move it to net.c
>> > following the above suggestions, keeping it consistent with other tests
>> > in net.c . You don't need the test_open() nor create_ruleset() helpers.
>> > 
>> > This test must failed if we change "ruleset->access_masks[layer_level] |="
>> > to "ruleset->access_masks[layer_level] =" in
>> > landlock_add_fs_access_mask() or landlock_add_net_access_mask().
>> 
>>   Do you want to change it? Why?
> 
> The kernel code is correct and must not be changed. However, if by
> mistake we change it and remove the OR, a test should catch that. We
> need a test to assert this assumption.
> 
   OK. I will add additional assert simulating 
"ruleset->access_masks[layer_level] =" kernel code.
>>   Fs and network masks are ORed to not intersect with each other.
> 
> Yes, they are ORed, and we need a test to check that. Noting is
> currently testing this OR (and the different rule type consistency).
> I'm suggesting to revamp the layout1.with_net test into
> ipv4_tcp.with_fs and make it check ruleset->access_masks[] and rule
> addition of different types.

   I will move layout1.with_net test into net.c and rename it. Looks like
   it just needed to add "ruleset->access_masks[layer_level] =" assert
   because the test already has rule addition with different types.

   Do you have any more review updates so far?
> 
>> > 
>> > >  	return new_ruleset;
>> > >  }
>> > > 
>> > > @@ -74,6 +84,11 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
>> > >  	case LANDLOCK_KEY_INODE:
>> > >  		return true;
>> > > 
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +	case LANDLOCK_KEY_NET_PORT:
>> > > +		return false;
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > >  	default:
>> > >  		WARN_ON_ONCE(1);
>> > >  		return false;
>> > > @@ -126,7 +141,13 @@ static struct rb_root *get_root(struct landlock_ruleset *const ruleset,
>> > >  	case LANDLOCK_KEY_INODE:
>> > >  		return &ruleset->root_inode;
>> > > 
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +	case LANDLOCK_KEY_NET_PORT:
>> > > +		return &ruleset->root_net_port;
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > >  	default:
>> > > +		WARN_ON_ONCE(1);
>> > 
>> > Please move this WARN to the patch that added the previous and next
>> > lines.
>> 
>>   OK. Will be moved.
>> > 
>> > >  		return ERR_PTR(-EINVAL);
>> > >  	}
>> > >  }
>> > > @@ -153,7 +174,8 @@ static void build_check_ruleset(void)
>> > >  	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
>> > >  	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
>> > >  	BUILD_BUG_ON(access_masks <
>> > > -		     (LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS));
>> > > +		     ((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
>> > > +		      (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET)));
>> > >  }
>> > > 
>> > >  /**
>> > > @@ -370,6 +392,13 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
>> > >  	if (err)
>> > >  		goto out_unlock;
>> > > 
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +	/* Merges the @src network port tree. */
>> > > +	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
>> > > +	if (err)
>> > > +		goto out_unlock;
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > >  out_unlock:
>> > >  	mutex_unlock(&src->lock);
>> > >  	mutex_unlock(&dst->lock);
>> > > @@ -426,6 +455,13 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
>> > >  	if (err)
>> > >  		goto out_unlock;
>> > > 
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +	/* Copies the @parent network port tree. */
>> > > +	err = inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
>> > > +	if (err)
>> > > +		goto out_unlock;
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > >  	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers)) {
>> > >  		err = -EINVAL;
>> > >  		goto out_unlock;
>> > > @@ -455,6 +491,13 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
>> > >  	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root_inode,
>> > >  					     node)
>> > >  		free_rule(freeme, LANDLOCK_KEY_INODE);
>> > > +
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +	rbtree_postorder_for_each_entry_safe(freeme, next,
>> > > +					     &ruleset->root_net_port, node)
>> > > +		free_rule(freeme, LANDLOCK_KEY_NET_PORT);
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > >  	put_hierarchy(ruleset->hierarchy);
>> > >  	kfree(ruleset);
>> > >  }
>> > > @@ -635,7 +678,8 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
>> > >   *
>> > >   * @domain: The domain that defines the current restrictions.
>> > >   * @access_request: The requested access rights to check.
>> > > - * @layer_masks: The layer masks to populate.
>> > > + * @layer_masks: It must contain LANDLOCK_NUM_ACCESS_FS or LANDLOCK_NUM_ACCESS_NET
>> > 
>> > "%LANDLOCK_NUM_ACCESS_FS or %LANDLOCK_NUM_ACCESS_NET"
>> 
>>   Done.
>> > 
>> > > + * elements according to @key_type.
>> > >   * @key_type: The key type to switch between access masks of different types.
>> > >   *
>> > >   * Returns: An access mask where each access right bit is set which is handled
>> > > @@ -656,6 +700,14 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
>> > >  		get_access_mask = landlock_get_fs_access_mask;
>> > >  		num_access = LANDLOCK_NUM_ACCESS_FS;
>> > >  		break;
>> > > +
>> > > +#if IS_ENABLED(CONFIG_INET)
>> > > +	case LANDLOCK_KEY_NET_PORT:
>> > > +		get_access_mask = landlock_get_net_access_mask;
>> > > +		num_access = LANDLOCK_NUM_ACCESS_NET;
>> > > +		break;
>> > > +#endif /* IS_ENABLED(CONFIG_INET) */
>> > > +
>> > >  	default:
>> > >  		WARN_ON_ONCE(1);
>> > >  		return 0;
>> > > diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
>> > > index 1ede2b9a79b7..ba4a06035599 100644
>> > > --- a/security/landlock/ruleset.h
>> > > +++ b/security/landlock/ruleset.h
>> > > @@ -33,13 +33,16 @@
>> > >  typedef u16 access_mask_t;
>> > >  /* Makes sure all filesystem access rights can be stored. */
>> > >  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>> > > +/* Makes sure all network access rights can be stored. */
>> > > +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
>> > >  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
>> > >  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>> > > 
>> > >  /* Ruleset access masks. */
>> > > -typedef u16 access_masks_t;
>> > > +typedef u32 access_masks_t;
>> > >  /* Makes sure all ruleset access rights can be stored. */
>> > > -static_assert(BITS_PER_TYPE(access_masks_t) >= LANDLOCK_NUM_ACCESS_FS);
>> > > +static_assert(BITS_PER_TYPE(access_masks_t) >=
>> > > +	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET);
>> > > 
>> > >  typedef u16 layer_mask_t;
>> > >  /* Makes sure all layers can be checked. */
>> > > @@ -84,6 +87,11 @@ enum landlock_key_type {
>> > >  	 * keys.
>> > >  	 */
>> > >  	LANDLOCK_KEY_INODE = 1,
>> > > +	/**
>> > > +	 * @LANDLOCK_KEY_NET_PORT: Type of &landlock_ruleset.root_net_port's
>> > > +	 * node keys.
>> > > +	 */
>> > > +	LANDLOCK_KEY_NET_PORT,
>> > >  };
>> > > 
>> > >  /**
>> > > @@ -158,6 +166,13 @@ struct landlock_ruleset {
>> > >  	 * reaches zero.
>> > >  	 */
>> > >  	struct rb_root root_inode;
>> > 
>> > #if IS_ENABLED(CONFIG_INET)
>>   OK. Done.
>> > > +	/**
>> > > +	 * @root_net_port: Root of a red-black tree containing &struct
>> > > +	 * landlock_rule nodes with network port. Once a ruleset is tied to a
>> > > +	 * process (i.e. as a domain), this tree is immutable until @usage
>> > > +	 * reaches zero.
>> > > +	 */
>> > > +	struct rb_root root_net_port;
>> > 
>> > #endif /* IS_ENABLED(CONFIG_INET) */
>> 
>>  Done.
>> > 
>> > >  	/**
>> > >  	 * @hierarchy: Enables hierarchy identification even when a parent
>> > >  	 * domain vanishes.  This is needed for the ptrace protection.
>> > > @@ -196,13 +211,13 @@ struct landlock_ruleset {
>> > >  			 */
>> > >  			u32 num_layers;
>> > >  			/**
>> > > -			 * @access_masks: Contains the subset of filesystem
>> > > -			 * actions that are restricted by a ruleset.  A domain
>> > > -			 * saves all layers of merged rulesets in a stack
>> > > -			 * (FAM), starting from the first layer to the last
>> > > -			 * one.  These layers are used when merging rulesets,
>> > > -			 * for user space backward compatibility (i.e.
>> > > -			 * future-proof), and to properly handle merged
>> > > +			 * @access_masks: Contains the subset of filesystem and
>> > > +			 * network actions that are restricted by a ruleset.
>> > > +			 * A domain saves all layers of merged rulesets in a
>> > > +			 * stack (FAM), starting from the first layer to the
>> > > +			 * last one.  These layers are used when merging
>> > > +			 * rulesets, for user space backward compatibility
>> > > +			 * (i.e. future-proof), and to properly handle merged
>> > >  			 * rulesets without overlapping access rights.  These
>> > >  			 * layers are set once and never changed for the
>> > >  			 * lifetime of the ruleset.
>> > > @@ -213,7 +228,8 @@ struct landlock_ruleset {
>> > >  };
>> > > 
>> > >  struct landlock_ruleset *
>> > > -landlock_create_ruleset(const access_mask_t access_mask);
>> > > +landlock_create_ruleset(const access_mask_t access_mask_fs,
>> > > +			const access_mask_t access_mask_net);
>> > > 
>> > >  void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
>> > >  void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
>> > > @@ -249,6 +265,19 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>> > >  		(fs_mask << LANDLOCK_SHIFT_ACCESS_FS);
>> > >  }
>> > > 
>> > > +static inline void
>> > > +landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
>> > > +			     const access_mask_t net_access_mask,
>> > > +			     const u16 layer_level)
>> > > +{
>> > > +	access_mask_t net_mask = net_access_mask & LANDLOCK_MASK_ACCESS_NET;
>> > > +
>> > > +	/* Should already be checked in sys_landlock_create_ruleset(). */
>> > > +	WARN_ON_ONCE(net_access_mask != net_mask);
>> > > +	ruleset->access_masks[layer_level] |=
>> > > +		(net_mask << LANDLOCK_SHIFT_ACCESS_NET);
>> > > +}
>> > > +
>> > >  static inline access_mask_t
>> > >  landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
>> > >  				const u16 layer_level)
>> > > @@ -266,6 +295,16 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
>> > >  	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
>> > >  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>> > >  }
>> > > +
>> > > +static inline access_mask_t
>> > > +landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
>> > > +			     const u16 layer_level)
>> > > +{
>> > > +	return (ruleset->access_masks[layer_level] >>
>> > > +		LANDLOCK_SHIFT_ACCESS_NET) &
>> > > +	       LANDLOCK_MASK_ACCESS_NET;
>> > > +}
>> > > +
>> > >  bool landlock_unmask_layers(const struct landlock_rule *const rule,
>> > >  			    const access_mask_t access_request,
>> > >  			    layer_mask_t (*const layer_masks)[],
>> > > diff --git a/security/landlock/setup.c b/security/landlock/setup.c
>> > > index 0f6113528fa4..df81612811bf 100644
>> > > --- a/security/landlock/setup.c
>> > > +++ b/security/landlock/setup.c
>> > > @@ -14,6 +14,7 @@
>> > >  #include "fs.h"
>> > >  #include "ptrace.h"
>> > >  #include "setup.h"
>> > > +#include "net.h"
>> > > 
>> > >  bool landlock_initialized __ro_after_init = false;
>> > > 
>> > > @@ -29,6 +30,7 @@ static int __init landlock_init(void)
>> > >  	landlock_add_cred_hooks();
>> > >  	landlock_add_ptrace_hooks();
>> > >  	landlock_add_fs_hooks();
>> > > +	landlock_add_net_hooks();
>> > >  	landlock_initialized = true;
>> > >  	pr_info("Up and running.\n");
>> > >  	return 0;
>> > > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
>> > > index 8a54e87dbb17..3ad652d9a146 100644
>> > > --- a/security/landlock/syscalls.c
>> > > +++ b/security/landlock/syscalls.c
>> > > @@ -29,6 +29,7 @@
>> > >  #include "cred.h"
>> > >  #include "fs.h"
>> > >  #include "limits.h"
>> > > +#include "net.h"
>> > >  #include "ruleset.h"
>> > >  #include "setup.h"
>> > > 
>> > > @@ -74,7 +75,8 @@ static void build_check_abi(void)
>> > >  {
>> > >  	struct landlock_ruleset_attr ruleset_attr;
>> > >  	struct landlock_path_beneath_attr path_beneath_attr;
>> > > -	size_t ruleset_size, path_beneath_size;
>> > > +	struct landlock_net_port_attr net_port_attr;
>> > > +	size_t ruleset_size, path_beneath_size, net_port_size;
>> > > 
>> > >  	/*
>> > >  	 * For each user space ABI structures, first checks that there is no
>> > > @@ -82,13 +84,19 @@ static void build_check_abi(void)
>> > >  	 * struct size.
>> > >  	 */
>> > >  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
>> > > +	ruleset_size += sizeof(ruleset_attr.handled_access_net);
>> > >  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
>> > > -	BUILD_BUG_ON(sizeof(ruleset_attr) != 8);
>> > > +	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
>> > > 
>> > >  	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
>> > >  	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
>> > >  	BUILD_BUG_ON(sizeof(path_beneath_attr) != path_beneath_size);
>> > >  	BUILD_BUG_ON(sizeof(path_beneath_attr) != 12);
>> > > +
>> > > +	net_port_size = sizeof(net_port_attr.allowed_access);
>> > > +	net_port_size += sizeof(net_port_attr.port);
>> > > +	BUILD_BUG_ON(sizeof(net_port_attr) != net_port_size);
>> > > +	BUILD_BUG_ON(sizeof(net_port_attr) != 16);
>> > >  }
>> > > 
>> > >  /* Ruleset handling */
>> > > @@ -129,7 +137,7 @@ static const struct file_operations ruleset_fops = {
>> > >  	.write = fop_dummy_write,
>> > >  };
>> > > 
>> > > -#define LANDLOCK_ABI_VERSION 3
>> > > +#define LANDLOCK_ABI_VERSION 4
>> > > 
>> > >  /**
>> > >   * sys_landlock_create_ruleset - Create a new ruleset
>> > > @@ -188,8 +196,14 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>> > >  	    LANDLOCK_MASK_ACCESS_FS)
>> > >  		return -EINVAL;
>> > > 
>> > > +	/* Checks network content (and 32-bits cast). */
>> > > +	if ((ruleset_attr.handled_access_net | LANDLOCK_MASK_ACCESS_NET) !=
>> > > +	    LANDLOCK_MASK_ACCESS_NET)
>> > > +		return -EINVAL;
>> > > +
>> > >  	/* Checks arguments and transforms to kernel struct. */
>> > > -	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs);
>> > > +	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
>> > > +					  ruleset_attr.handled_access_net);
>> > >  	if (IS_ERR(ruleset))
>> > >  		return PTR_ERR(ruleset);
>> > > 
>> > > @@ -282,7 +296,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>> > >  	int res, err;
>> > >  	access_mask_t mask;
>> > > 
>> > > -	/* Copies raw user space buffer, only one type for now. */
>> > > +	/* Copies raw user space buffer. */
>> > 
>> > Shouldn't this be part of a previous patch?
>> 
>> I did it according Gunter's suggestion
>> https://lore.kernel.org/netdev/20230627.82cde73b1efe@gnoack.org/
> 
> Ok, that indeed makes more sense in this patch, please keep it.

   OK.
> 
>> > 
>> > >  	res = copy_from_user(&path_beneath_attr, rule_attr,
>> > >  			     sizeof(path_beneath_attr));
>> > >  	if (res)
>> > > @@ -315,13 +329,49 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>> > >  	return err;
>> > >  }
>> > > 
>> > > +static int add_rule_net_port(struct landlock_ruleset *ruleset,
>> > > +			     const void __user *const rule_attr)
>> > > +{
>> > > +	struct landlock_net_port_attr net_port_attr;
>> > > +	int res;
>> > > +	access_mask_t mask;
>> > > +
>> > > +	/* Copies raw user space buffer. */
>> > > +	res = copy_from_user(&net_port_attr, rule_attr, sizeof(net_port_attr));
>> > > +	if (res)
>> > > +		return -EFAULT;
>> > > +
>> > > +	/*
>> > > +	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
>> > > +	 * are ignored by network actions.
>> > > +	 */
>> > > +	if (!net_port_attr.allowed_access)
>> > > +		return -ENOMSG;
>> > > +
>> > > +	/*
>> > > +	 * Checks that allowed_access matches the @ruleset constraints
>> > > +	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
>> > > +	 */
>> > > +	mask = landlock_get_net_access_mask(ruleset, 0);
>> > > +	if ((net_port_attr.allowed_access | mask) != mask)
>> > > +		return -EINVAL;
>> > > +
>> > > +	/* Denies inserting a rule with port higher than 65535. */
>> > 
>> > For consistency with the following comment:
>> > "Denies inserting a rule with port greater than 65535."
>> > 
>>   Done. Thanks.
>> > 
>> > > +	if (net_port_attr.port > U16_MAX)
>> > > +		return -EINVAL;
>> > > +
>> > > +	/* Imports the new rule. */
>> > > +	return landlock_append_net_rule(ruleset, net_port_attr.port,
>> > > +					net_port_attr.allowed_access);
>> > > +}
>> > > +
>> > >  /**
>> > >   * sys_landlock_add_rule - Add a new rule to a ruleset
>> > >   *
>> > >   * @ruleset_fd: File descriptor tied to the ruleset that should be extended
>> > >   *		with the new rule.
>> > > - * @rule_type: Identify the structure type pointed to by @rule_attr (only
>> > > - *             %LANDLOCK_RULE_PATH_BENEATH for now).
>> > > + * @rule_type: Identify the structure type pointed to by @rule_attr:
>> > > + *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
>> > >   * @rule_attr: Pointer to a rule (only of type &struct
>> > >   *             landlock_path_beneath_attr for now).
>> > >   * @flags: Must be 0.
>> > > @@ -332,6 +382,8 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>> > >   * Possible returned errors are:
>> > >   *
>> > >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>> > > + * - %EAFNOSUPPORT: @rule_type is LANDLOCK_RULE_NET_PORT but TCP/IP is not
>> > 
>> > %LANDLOCK_RULE_NET_PORT
>> 
>>  Done.
>> > 
>> > > + *   supported by the running kernel;
>> > >   * - %EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
>> > >   *   &landlock_path_beneath_attr.allowed_access is not a subset of the
>> > 
>> > &landlock_path_beneath_attr.allowed_access or
>> > &landlock_net_port_attr.allowed_access is not a subset of the
>> 
>>   Fixed. Thanks.
>> > 
>> > >   *   ruleset handled accesses);
>> > 
>> > EINVAL description needs to be updated, especially for port > U16_MAX:
>> > - *   ruleset handled accesses);
>> > + *   ruleset handled accesses), or &landlock_net_port_attr.port is
>> > +     greater than 65535;
>> 
>>  Done. Thanks.
>> > 
>> > 
>> > > @@ -366,6 +418,9 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>> > >  	case LANDLOCK_RULE_PATH_BENEATH:
>> > >  		err = add_rule_path_beneath(ruleset, rule_attr);
>> > >  		break;
>> > > +	case LANDLOCK_RULE_NET_PORT:
>> > > +		err = add_rule_net_port(ruleset, rule_attr);
>> > > +		break;
>> > >  	default:
>> > >  		err = -EINVAL;
>> > >  		break;
>> > > diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
>> > > index 792c3f0a59b4..646f778dfb1e 100644
>> > > --- a/tools/testing/selftests/landlock/base_test.c
>> > > +++ b/tools/testing/selftests/landlock/base_test.c
>> > > @@ -75,7 +75,7 @@ TEST(abi_version)
>> > >  	const struct landlock_ruleset_attr ruleset_attr = {
>> > >  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>> > >  	};
>> > > -	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
>> > > +	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
>> > >  					     LANDLOCK_CREATE_RULESET_VERSION));
>> > > 
>> > >  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
>> > > --
>> > > 2.25.1
>> > > 
>> > .
> .
