Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED46583B1F
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Jul 2022 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiG1JUh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Jul 2022 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiG1JUg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:20:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D84B0F1;
        Thu, 28 Jul 2022 02:20:35 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LtlQL6Fwfz67Hm8;
        Thu, 28 Jul 2022 17:16:42 +0800 (CST)
Received: from lhreml745-chm.china.huawei.com (10.201.108.195) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 11:20:33 +0200
Received: from [10.122.132.241] (10.122.132.241) by
 lhreml745-chm.china.huawei.com (10.201.108.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 10:20:32 +0100
Message-ID: <63e587ae-bd91-5448-60b6-2ef1eed10be7@huawei.com>
Date:   Thu, 28 Jul 2022 12:20:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 00/17] Network support for Landlock
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <anton.sirazetdinov@huawei.com>
References: <20220621082313.3330667-1-konstantin.meskhidze@huawei.com>
 <4c57a0c2-e207-10d6-c73d-bcda66bf3963@digikod.net>
 <75c66214-5735-36d8-b237-32dd9af48a4f@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <75c66214-5735-36d8-b237-32dd9af48a4f@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.132.241]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml745-chm.china.huawei.com (10.201.108.195)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



7/27/2022 11:21 PM, Mickaël Salaün пишет:
> 
> On 26/07/2022 19:43, Mickaël Salaün wrote:
>> 
>> On 21/06/2022 10:22, Konstantin Meskhidze wrote:
>>> Hi,
>>> This is a new V6 patch related to Landlock LSM network confinement.
>>> It is based on the latest landlock-wip branch on top of v5.19-rc2:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=landlock-wip
>>>
>>> It brings refactoring of previous patch version V5:
>>>      - Fixes some logic errors and typos.
>>>      - Adds additional FIXTURE_VARIANT and FIXTURE_VARIANT_ADD helpers
>>>      to support both ip4 and ip6 families and shorten seltests' code.
>>>      - Makes TCP sockets confinement support optional in sandboxer demo.
>>>      - Formats the code with clang-format-14
>>>
>>> All test were run in QEMU evironment and compiled with
>>>   -static flag.
>>>   1. network_test: 18/18 tests passed.
>>>   2. base_test: 7/7 tests passed.
>>>   3. fs_test: 59/59 tests passed.
>>>   4. ptrace_test: 8/8 tests passed.
>>>
>>> Still have issue with base_test were compiled without -static flag
>>> (landlock-wip branch without network support)
>>> 1. base_test: 6/7 tests passed.
>>>   Error:
>>>   #  RUN           global.inconsistent_attr ...
>>>   # base_test.c:54:inconsistent_attr:Expected ENOMSG (42) == errno (22)
>>>   # inconsistent_attr: Test terminated by assertion
>>>   #          FAIL  global.inconsistent_attr
>>> not ok 1 global.inconsistent_attr
>>>
>>> LCOV - code coverage report:
>>>              Hit  Total  Coverage
>>> Lines:      952  1010    94.3 %
>>> Functions:  79   82      96.3 %
>>>
>>> Previous versions:
>>> v5: 
>>> https://lore.kernel.org/linux-security-module/20220516152038.39594-1-konstantin.meskhidze@huawei.com
>>> v4: 
>>> https://lore.kernel.org/linux-security-module/20220309134459.6448-1-konstantin.meskhidze@huawei.com/
>>> v3: 
>>> https://lore.kernel.org/linux-security-module/20220124080215.265538-1-konstantin.meskhidze@huawei.com/
>>> v2: 
>>> https://lore.kernel.org/linux-security-module/20211228115212.703084-1-konstantin.meskhidze@huawei.com/
>>> v1: 
>>> https://lore.kernel.org/linux-security-module/20211210072123.386713-1-konstantin.meskhidze@huawei.com/
>>>
>>> Konstantin Meskhidze (17):
>>>    landlock: renames access mask
>>>    landlock: refactors landlock_find/insert_rule
>>>    landlock: refactors merge and inherit functions
>>>    landlock: moves helper functions
>>>    landlock: refactors helper functions
>>>    landlock: refactors landlock_add_rule syscall
>>>    landlock: user space API network support
>>>    landlock: adds support network rules
>>>    landlock: implements TCP network hooks
>>>    seltests/landlock: moves helper function
>>>    seltests/landlock: adds tests for bind() hooks
>>>    seltests/landlock: adds tests for connect() hooks
>>>    seltests/landlock: adds AF_UNSPEC family test
>>>    seltests/landlock: adds rules overlapping test
>>>    seltests/landlock: adds ruleset expanding test
>>>    seltests/landlock: adds invalid input data test
>>>    samples/landlock: adds network demo
>>>
>>>   include/uapi/linux/landlock.h               |  49 ++
>>>   samples/landlock/sandboxer.c                | 118 ++-
>>>   security/landlock/Kconfig                   |   1 +
>>>   security/landlock/Makefile                  |   2 +
>>>   security/landlock/fs.c                      | 162 +---
>>>   security/landlock/limits.h                  |   8 +-
>>>   security/landlock/net.c                     | 155 ++++
>>>   security/landlock/net.h                     |  26 +
>>>   security/landlock/ruleset.c                 | 448 +++++++++--
>>>   security/landlock/ruleset.h                 |  91 ++-
>>>   security/landlock/setup.c                   |   2 +
>>>   security/landlock/syscalls.c                | 168 +++--
>>>   tools/testing/selftests/landlock/common.h   |  10 +
>>>   tools/testing/selftests/landlock/config     |   4 +
>>>   tools/testing/selftests/landlock/fs_test.c  |  10 -
>>>   tools/testing/selftests/landlock/net_test.c | 774 ++++++++++++++++++++
>>>   16 files changed, 1737 insertions(+), 291 deletions(-)
>>>   create mode 100644 security/landlock/net.c
>>>   create mode 100644 security/landlock/net.h
>>>   create mode 100644 tools/testing/selftests/landlock/net_test.c
>>>
>>> -- 
>>> 2.25.1
>>>
>> 
>> I did a thorough review of all the code. I found that the main issue 
>> with this version is that we stick to the layers limit whereas it is 
>> only relevant for filesystem hierarchies. You'll find in the following 
>> patch miscellaneous fixes and improvement, with some TODOs to get rid of 
>> this layer limit. We'll need a test to check that too. You'll need to 
>> integrate this diff into your patches though.
>> 
>> 
> 
> [...]
> 
>> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
>> index 469811a77675..e7555b16069a 100644
>> --- a/security/landlock/ruleset.c
>> +++ b/security/landlock/ruleset.c
> 
> [...]
> 
>> @@ -719,15 +679,43 @@ bool unmask_layers(const struct landlock_rule 
>> *const rule,
>>       return false;
>>   }
>> 
>> +typedef access_mask_t
>> +get_access_mask_t(const struct landlock_ruleset *const ruleset,
>> +          const u16 layer_level);
>> +
>> +/*
>> + * @layer_masks must contain LANDLOCK_NUM_ACCESS_FS or 
>> LANDLOCK_NUM_ACCESS_NET
>> + * elements according to @key_type.
>> + */
>>   access_mask_t init_layer_masks(const struct landlock_ruleset *const 
>> domain,
>>                      const access_mask_t access_request,
>>                      layer_mask_t (*const layer_masks)[],
>> -                   size_t masks_size, u16 rule_type)
>> +                   const enum landlock_key_type key_type)
>>   {
>>       access_mask_t handled_accesses = 0;
>> -    size_t layer_level;
>> +    size_t layer_level, num_access;
>> +    get_access_mask_t *get_access_mask;
>> +
>> +    switch (key_type) {
>> +    case LANDLOCK_KEY_INODE:
>> +        // XXX: landlock_get_fs_access_mask() should not be removed
> 
> There is an extra "not", it should be: "landlock_get_fs_access_mask()
> and landlock_get_net_access_mask() should be removed".
> 
   I got it. Will be fixed.
   Thank you!
> 
>> +        // once we use ruleset->net_access_mask, and we can then
>> +        // replace the @key_type argument with num_access to make the
>> +        // code simpler.
>> +        get_access_mask = landlock_get_fs_access_mask;
>> +        num_access = LANDLOCK_NUM_ACCESS_FS;
>> +        break;
>> +    case LANDLOCK_KEY_NET_PORT:
>> +        get_access_mask = landlock_get_net_access_mask;
>> +        num_access = LANDLOCK_NUM_ACCESS_NET;
>> +        break;
>> +    default:
>> +        WARN_ON_ONCE(1);
>> +        return 0;
>> +    }
> .
