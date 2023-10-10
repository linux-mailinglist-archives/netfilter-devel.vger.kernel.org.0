Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636617BF995
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Oct 2023 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJJLWc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Oct 2023 07:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJJLWb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:22:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607429E;
        Tue, 10 Oct 2023 04:22:29 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S4YMM3vp6z6D8jQ;
        Tue, 10 Oct 2023 19:19:27 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 12:22:26 +0100
Message-ID: <12f5d756-7d3a-1d71-1199-52effc224a17@huawei.com>
Date:   Tue, 10 Oct 2023 14:22:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v12 08/12] landlock: Add network rules and TCP hooks
 support
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
References: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
 <20230920092641.832134-9-konstantin.meskhidze@huawei.com>
 <20231001.oobeez8AeYae@digikod.net> <20231009.meet7uTaeghu@digikod.net>
 <8d409496-ef12-95c1-46e7-fdcffdda6c62@huawei.com>
 <20231010.eiNgicei8Ies@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <20231010.eiNgicei8Ies@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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



10/10/2023 12:17 PM, Mickaël Salaün пишет:
> On Tue, Oct 10, 2023 at 05:20:45AM +0300, Konstantin Meskhidze (A) wrote:
>> 
>> 
>> 10/9/2023 5:12 PM, Mickaël Salaün пишет:
>> > On Mon, Oct 02, 2023 at 10:26:36PM +0200, Mickaël Salaün wrote:
>> > > Thanks for this new version Konstantin. I pushed this series, with minor
>> > > changes, to -next. So far, no warning. But it needs some changes, mostly
>> > > kernel-only, but also one with the handling of port 0 with bind (see my
>> > > review below).
>> > > 
>> > > On Wed, Sep 20, 2023 at 05:26:36PM +0800, Konstantin Meskhidze wrote:
>> > > > This commit adds network rules support in the ruleset management
>> > > > helpers and the landlock_create_ruleset syscall.
>> > > > Refactor user space API to support network actions. Add new network
>> > > > access flags, network rule and network attributes. Increment Landlock
>> > > > ABI version. Expand access_masks_t to u32 to be sure network access
>> > > > rights can be stored. Implement socket_bind() and socket_connect()
>> > > > LSM hooks, which enables to restrict TCP socket binding and connection
>> > > > to specific ports.
>> > > > The new landlock_net_port_attr structure has two fields. The allowed_access
>> > > > field contains the LANDLOCK_ACCESS_NET_* rights. The port field contains
>> > > > the port value according to the allowed protocol. This field can
>> > > > take up to a 64-bit value [1] but the maximum value depends on the related
>> > > > protocol (e.g. 16-bit for TCP).
>> > > > > [1]
>> > > > https://lore.kernel.org/r/278ab07f-7583-a4e0-3d37-1bacd091531d@digikod.net
>> > > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> > > > Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> > > > ---
>> > > > > Changes since v11:
>> > > > * Replace dates with "2022-2023" in net.c/h files headers.
>> > > > * Removes WARN_ON_ONCE(!domain) in check_socket_access().
>> > > > * Using "typeof(*address)" instead of offsetofend(struct sockaddr, sa_family).
>> > > > * Renames LANDLOCK_RULE_NET_SERVICE to LANDLOCK_RULE_NET_PORT.
>> > > > * Renames landlock_net_service_attr to landlock_net_port_attr.
>> > > > * Defines two add_rule_net_service() functions according to
>> > > >   IS_ENABLED(CONFIG_INET) instead of changing the body of the only
>> > > >   function.
>> > > > * Adds af_family consistency check while handling AF_UNSPEC specifically.
>> > > > * Adds bind_access_mask in add_rule_net_service() to deny all rules with bind
>> > > >   action on port zero.
>> > > > * Minor fixes.
>> > > > * Refactors commit message.
>> > > > > Changes since v10:
>> > > > * Removes "packed" attribute.
>> > > > * Applies Mickaёl's patch with some refactoring.
>> > > > * Deletes get_port() and check_addrlen() helpers.
>> > > > * Refactors check_socket_access() by squashing get_port() and
>> > > >   check_addrlen() helpers into it.
>> > > > * Fixes commit message.
>> > > > > Changes since v9:
>> > > > * Changes UAPI port field to __u64.
>> > > > * Moves shared code into check_socket_access().
>> > > > * Adds get_raw_handled_net_accesses() and
>> > > >   get_current_net_domain() helpers.
>> > > > * Minor fixes.
>> > > > > Changes since v8:
>> > > > * Squashes commits.
>> > > > * Refactors commit message.
>> > > > * Changes UAPI port field to __be16.
>> > > > * Changes logic of bind/connect hooks with AF_UNSPEC families.
>> > > > * Adds address length checking.
>> > > > * Minor fixes.
>> > > > > Changes since v7:
>> > > > * Squashes commits.
>> > > > * Increments ABI version to 4.
>> > > > * Refactors commit message.
>> > > > * Minor fixes.
>> > > > > Changes since v6:
>> > > > * Renames landlock_set_net_access_mask() to landlock_add_net_access_mask()
>> > > >   because it OR values.
>> > > > * Makes landlock_add_net_access_mask() more resilient incorrect values.
>> > > > * Refactors landlock_get_net_access_mask().
>> > > > * Renames LANDLOCK_MASK_SHIFT_NET to LANDLOCK_SHIFT_ACCESS_NET and use
>> > > >   LANDLOCK_NUM_ACCESS_FS as value.
>> > > > * Updates access_masks_t to u32 to support network access actions.
>> > > > * Refactors landlock internal functions to support network actions with
>> > > >   landlock_key/key_type/id types.
>> > > > > Changes since v5:
>> > > > * Gets rid of partial revert from landlock_add_rule
>> > > > syscall.
>> > > > * Formats code with clang-format-14.
>> > > > > Changes since v4:
>> > > > * Refactors landlock_create_ruleset() - splits ruleset and
>> > > > masks checks.
>> > > > * Refactors landlock_create_ruleset() and landlock mask
>> > > > setters/getters to support two rule types.
>> > > > * Refactors landlock_add_rule syscall add_rule_path_beneath
>> > > > function by factoring out get_ruleset_from_fd() and
>> > > > landlock_put_ruleset().
>> > > > > Changes since v3:
>> > > > * Splits commit.
>> > > > * Adds network rule support for internal landlock functions.
>> > > > * Adds set_mask and get_mask for network.
>> > > > * Adds rb_root root_net_port.
>> > > > > ---
>> > > >  include/uapi/linux/landlock.h                |  47 ++++
>> > > >  security/landlock/Kconfig                    |   3 +-
>> > > >  security/landlock/Makefile                   |   2 +
>> > > >  security/landlock/limits.h                   |   5 +
>> > > >  security/landlock/net.c                      | 241 +++++++++++++++++++
>> > > >  security/landlock/net.h                      |  35 +++
>> > > >  security/landlock/ruleset.c                  |  62 ++++-
>> > > >  security/landlock/ruleset.h                  |  59 ++++-
>> > > >  security/landlock/setup.c                    |   2 +
>> > > >  security/landlock/syscalls.c                 |  33 ++-
>> > > >  tools/testing/selftests/landlock/base_test.c |   2 +-
>> > > >  11 files changed, 467 insertions(+), 24 deletions(-)
>> > > >  create mode 100644 security/landlock/net.c
>> > > >  create mode 100644 security/landlock/net.h
>> > > >
>> > 
>> > > > diff --git a/security/landlock/net.c b/security/landlock/net.c
>> > > > new file mode 100644
>> > > > index 000000000000..62b830653e25
>> > > > --- /dev/null
>> > > > +++ b/security/landlock/net.c
>> > > > @@ -0,0 +1,241 @@
>> > > > +// SPDX-License-Identifier: GPL-2.0-only
>> > > > +/*
>> > > > + * Landlock LSM - Network management and hooks
>> > > > + *
>> > > > + * Copyright © 2022-2023 Huawei Tech. Co., Ltd.
>> > > > + * Copyright © 2022-2023 Microsoft Corporation
>> > > > + */
>> > > > +
>> > > > +#include <linux/in.h>
>> > > > +#include <linux/net.h>
>> > > > +#include <linux/socket.h>
>> > > > +#include <net/ipv6.h>
>> > > > +
>> > > > +#include "common.h"
>> > > > +#include "cred.h"
>> > > > +#include "limits.h"
>> > > > +#include "net.h"
>> > > > +#include "ruleset.h"
>> > > > +
>> > > > +int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
>> > > > +			     const u16 port, access_mask_t access_rights)
>> > > 
>> > > This function is only used in add_rule_net_service(), so it should not
>> > > be exported, and we can merge it (into landlock_add_rule_net_port).
>> > > 
>> > > > +{
>> > > > +	int err;
>> > > > +	const struct landlock_id id = {
>> > > > +		.key.data = (__force uintptr_t)htons(port),
>> > > > +		.type = LANDLOCK_KEY_NET_PORT,
>> > > > +	};
>> > > > +
>> > > > +	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
>> > > > +
>> > > > +	/* Transforms relative access rights to absolute ones. */
>> > > > +	access_rights |= LANDLOCK_MASK_ACCESS_NET &
>> > > > +			 ~landlock_get_net_access_mask(ruleset, 0);
>> > > > +
>> > > > +	mutex_lock(&ruleset->lock);
>> > > > +	err = landlock_insert_rule(ruleset, id, access_rights);
>> > > > +	mutex_unlock(&ruleset->lock);
>> > > > +
>> > > > +	return err;
>> > > > +}
>> > > > +
>> > > > +int add_rule_net_service(struct landlock_ruleset *ruleset,
>> > > 
>> > > We should only export functions with a "landlock_" prefix, and "service"
>> > > is now replaced with "port", which gives landlock_add_rule_net_port().
>> > > 
>> > > For consistency, we should also rename add_rule_path_beneath() into
>> > > landlock_add_rule_path_beneath(), move it into fs.c, and merge
>> > > landlock_append_fs_rule() into it (being careful to not move the related
>> > > code to ease review). This change should be part of the "landlock:
>> > > Refactor landlock_add_rule() syscall" patch. Please be careful to keep
>> > > the other changes happening in other patches.
>> > > 
>> > > 
>> > > > +			 const void __user *const rule_attr)
>> > > > +{
>> > > > +	struct landlock_net_port_attr net_port_attr;
>> > > > +	int res;
>> > > > +	access_mask_t mask, bind_access_mask;
>> > > > +
>> > > > +	/* Copies raw user space buffer. */
>> > > > +	res = copy_from_user(&net_port_attr, rule_attr, sizeof(net_port_attr));
>> > > 
>> > > We should include <linux/uaccess.h> because of copy_from_user().
>> > > 
>> > > Same for landlock_add_rule_path_beneath().
>> > > 
>> > > > +	if (res)
>> > > > +		return -EFAULT;
>> > > > +
>> > > > +	/*
>> > > > +	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
>> > > > +	 * are ignored by network actions.
>> > > > +	 */
>> > > > +	if (!net_port_attr.allowed_access)
>> > > > +		return -ENOMSG;
>> > > > +
>> > > > +	/*
>> > > > +	 * Checks that allowed_access matches the @ruleset constraints
>> > > > +	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
>> > > > +	 */
>> > > > +	mask = landlock_get_net_access_mask(ruleset, 0);
>> > > > +	if ((net_port_attr.allowed_access | mask) != mask)
>> > > > +		return -EINVAL;
>> > > > +
>> > > > +	/*
>> > > > +	 * Denies inserting a rule with port 0 (for bind action) or
>> > > > +	 * higher than 65535.
>> > > > +	 */
>> > > > +	bind_access_mask = net_port_attr.allowed_access &
>> > > > +			   LANDLOCK_ACCESS_NET_BIND_TCP;
>> > > > +	if (((net_port_attr.port == 0) &&
>> > > > +	     (bind_access_mask == LANDLOCK_ACCESS_NET_BIND_TCP)) ||
>> > > > +	    (net_port_attr.port > U16_MAX))
>> > > > +		return -EINVAL;
>> > > > +
>> > > > +	/* Imports the new rule. */
>> > > > +	return landlock_append_net_rule(ruleset, net_port_attr.port,
>> > > > +					net_port_attr.allowed_access);
>> > > > +}
>> > 
>> > Please ignore the above suggestions. Thinking more about this, let's
>> > keep the static add_rule_net_service() in syscalls.c, and only make the
>> > inline landlock_add_rule_net_service() return -EAFNOSUPPORT (which is
>> > already the case with this patch when CONFIG_INET is not set). This will
>> > slightly change the current semantic but enable to check all the
>> > syscalls arguments even if CONFIG_INET is not set, which is a good thing
>> > (and should be reflected in tests). It is better to group all the code
>> > handling user space memory copying and ABI specificities in the
>> > syscalls.c file. This approach is simpler, it will avoid the exported
>> > function issues (e.g. add_rule_net_service), and it will not require
>> > more changes to the fs.[ch] files.
>> > .
>>   Ok.Will be moved back to syscalls.c.
>>   What about renaming to add_rule_net_service()->add_rule_net_port() ???
> 
> Yes please rename it, there should be no mention of "net_service"
> anymore.

   Got it. Thanks.
> .
