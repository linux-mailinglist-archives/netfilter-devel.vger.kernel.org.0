Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E09A52D63E
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 May 2022 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiESOhd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 May 2022 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbiESOhb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 May 2022 10:37:31 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E3EAFB08
        for <netfilter-devel@vger.kernel.org>; Thu, 19 May 2022 07:37:20 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L3srb0k5dzMrB6s;
        Thu, 19 May 2022 16:37:19 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4L3srZ48DrzlhRVH;
        Thu, 19 May 2022 16:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652971039;
        bh=i8dfsC9vYadjnpOI+wE6Qwms1Yeulf9OeJQBKI2qsco=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=kuYOZqdhAAAVZzSSIFfz8WIDv9jY5hcaXXQDpf5gToKoOBw0pw0x33Gfm/fHmGjG1
         Yx4CezO2ed8SPwmr+ibrBA23JCIcPyDvTKXG59vQaGGwSkALr1QLhaOp9Ly0+gDGEi
         OkKCbHRfm+sxtwGQun25wcPQLMPajZSe14fmqgDk=
Message-ID: <8683502f-113d-fafd-be85-30cf829fb018@digikod.net>
Date:   Thu, 19 May 2022 16:37:17 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        anton.sirazetdinov@huawei.com
References: <20220516152038.39594-1-konstantin.meskhidze@huawei.com>
 <20220516152038.39594-6-konstantin.meskhidze@huawei.com>
 <9456ccf3-e2b3-bb65-f24f-e6d2761120e5@digikod.net>
 <6edfec5b-1b56-17cc-7c0c-76fda1391d45@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v5 05/15] landlock: landlock_add_rule syscall refactoring
In-Reply-To: <6edfec5b-1b56-17cc-7c0c-76fda1391d45@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



On 19/05/2022 11:23, Konstantin Meskhidze wrote:
> 
> 
> 5/17/2022 11:04 AM, Mickaël Salaün пишет:
>> You can rename the subject to "landlock: Refactor landlock_add_rule()"
>>
>>
>> On 16/05/2022 17:20, Konstantin Meskhidze wrote:
>>> Landlock_add_rule syscall was refactored to support new
>>> rule types in future Landlock versions. Add_rule_path_beneath()
>>
>> nit: add_rule_path_beneath(), not Add_rule_path_beneath()
>>
>    Ok. Thanks. Will be renamed.
> 
>>> helper was added to support current filesystem rules. It is called
>>> by the switch case.
>>
>> You can rephrase (all commit messages) in the present form:
>>
>> Refactor the landlock_add_rule() syscall with add_rule_path_beneath() 
>> to support new…
>>
>> Refactor the landlock_add_rule() syscall to easily support for a new 
>> rule type in a following commit. The new add_rule_path_beneath() 
>> helper supports current filesystem rules.
>>
>    Ok. I will fix it.
>>
>>>
>>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>>> ---
>>>
>>> Changes since v3:
>>> * Split commit.
>>> * Refactoring landlock_add_rule syscall.
>>>
>>> Changes since v4:
>>> * Refactoring add_rule_path_beneath() and landlock_add_rule() functions
>>> to optimize code usage.
>>> * Refactoring base_test.c seltest: adds LANDLOCK_RULE_PATH_BENEATH
>>> rule type in landlock_add_rule() call.
>>>
>>> ---
>>>   security/landlock/syscalls.c                 | 105 ++++++++++---------
>>>   tools/testing/selftests/landlock/base_test.c |   4 +-
>>>   2 files changed, 59 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
>>> index 1db799d1a50b..412ced6c512f 100644
>>> --- a/security/landlock/syscalls.c
>>> +++ b/security/landlock/syscalls.c
>>> @@ -274,67 +274,23 @@ static int get_path_from_fd(const s32 fd, 
>>> struct path *const path)
>>>       return err;
>>>   }
>>>
>>> -/**
>>> - * sys_landlock_add_rule - Add a new rule to a ruleset
>>> - *
>>> - * @ruleset_fd: File descriptor tied to the ruleset that should be 
>>> extended
>>> - *        with the new rule.
>>> - * @rule_type: Identify the structure type pointed to by @rule_attr 
>>> (only
>>> - *             LANDLOCK_RULE_PATH_BENEATH for now).
>>> - * @rule_attr: Pointer to a rule (only of type &struct
>>> - *             landlock_path_beneath_attr for now).
>>> - * @flags: Must be 0.
>>> - *
>>> - * This system call enables to define a new rule and add it to an 
>>> existing
>>> - * ruleset.
>>> - *
>>> - * Possible returned errors are:
>>> - *
>>> - * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at 
>>> boot time;
>>> - * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
>>> - *   &landlock_path_beneath_attr.allowed_access is not a subset of the
>>> - *   ruleset handled accesses);
>>> - * - ENOMSG: Empty accesses (e.g. 
>>> &landlock_path_beneath_attr.allowed_access);
>>> - * - EBADF: @ruleset_fd is not a file descriptor for the current 
>>> thread, or a
>>> - *   member of @rule_attr is not a file descriptor as expected;
>>> - * - EBADFD: @ruleset_fd is not a ruleset file descriptor, or a 
>>> member of
>>> - *   @rule_attr is not the expected file descriptor type;
>>> - * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
>>> - * - EFAULT: @rule_attr inconsistency.
>>> - */
>>> -SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>>> -        const enum landlock_rule_type, rule_type,
>>> -        const void __user *const, rule_attr, const __u32, flags)
>>> +static int add_rule_path_beneath(const int ruleset_fd, const void 
>>> *const rule_attr)
>>>   {
>>>       struct landlock_path_beneath_attr path_beneath_attr;
>>>       struct path path;
>>>       struct landlock_ruleset *ruleset;
>>>       int res, err;
>>>
>>> -    if (!landlock_initialized)
>>> -        return -EOPNOTSUPP;
>>> -
>>> -    /* No flag for now. */
>>> -    if (flags)
>>> -        return -EINVAL;
>>> -
>>>       /* Gets and checks the ruleset. */
>>
>> Like I already said, this needs to stay in landlock_add_rule(). I 
>> think there is some inconsistencies with other patches that rechange 
>> this part. Please review your patches and make clean patches that 
>> don't partially revert the previous ones.
>>
>    Do you mean to leave this code as it its till adding network part
> in commit landlock: TCP network hooks implementation?
>   In this case this patch can be dropped.

The syscall argument check ordering needs to stay in the same order as 
you can see in the add_rule_checks_ordering test. Other than that, this 
commit looks good, it just splits the syscall in two functions, which is 
useful.


>>
>>>       ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
>>>       if (IS_ERR(ruleset))
>>>           return PTR_ERR(ruleset);
>>>
>>> -    if (rule_type != LANDLOCK_RULE_PATH_BENEATH) {
>>> -        err = -EINVAL;
>>> -        goto out_put_ruleset;
>>> -    }
>>> -
>>>       /* Copies raw user space buffer, only one type for now. */
>>>       res = copy_from_user(&path_beneath_attr, rule_attr,
>>> -                 sizeof(path_beneath_attr));
>>> -    if (res) {
>>> -        err = -EFAULT;
>>> -        goto out_put_ruleset;
>>> -    }
>>> +                sizeof(path_beneath_attr));
>>> +    if (res)
>>> +        return -EFAULT;
>>>
>>>       /*
>>>        * Informs about useless rule: empty allowed_access (i.e. deny 
>>> rules)
>>> @@ -370,6 +326,59 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, 
>>> ruleset_fd,
>>>       return err;
>>>   }
>>>
>>> +/**
>>> + * sys_landlock_add_rule - Add a new rule to a ruleset
>>> + *
>>> + * @ruleset_fd: File descriptor tied to the ruleset that should be 
>>> extended
>>> + *        with the new rule.
>>> + * @rule_type: Identify the structure type pointed to by @rule_attr 
>>> (only
>>> + *             LANDLOCK_RULE_PATH_BENEATH for now).
>>> + * @rule_attr: Pointer to a rule (only of type &struct
>>> + *             landlock_path_beneath_attr for now).
>>> + * @flags: Must be 0.
>>> + *
>>> + * This system call enables to define a new rule and add it to an 
>>> existing
>>> + * ruleset.
>>> + *
>>> + * Possible returned errors are:
>>> + *
>>> + * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at 
>>> boot time;
>>> + * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
>>> + *   &landlock_path_beneath_attr.allowed_access is not a subset of 
>>> the rule's
>>> + *   accesses);
>>> + * - ENOMSG: Empty accesses (e.g. 
>>> &landlock_path_beneath_attr.allowed_access);
>>> + * - EBADF: @ruleset_fd is not a file descriptor for the current 
>>> thread, or a
>>> + *   member of @rule_attr is not a file descriptor as expected;
>>> + * - EBADFD: @ruleset_fd is not a ruleset file descriptor, or a 
>>> member of
>>> + *   @rule_attr is not the expected file descriptor type (e.g. file 
>>> open
>>> + *   without O_PATH);
>>> + * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
>>> + * - EFAULT: @rule_attr inconsistency.
>>> + */
>>> +SYSCALL_DEFINE4(landlock_add_rule,
>>> +        const int, ruleset_fd, const enum landlock_rule_type, 
>>> rule_type,
>>> +        const void __user *const, rule_attr, const __u32, flags)
>>> +{
>>> +    int err;
>>> +
>>> +    if (!landlock_initialized)
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    /* No flag for now. */
>>> +    if (flags)
>>> +        return -EINVAL;
>>> +
>>> +    switch (rule_type) {
>>> +    case LANDLOCK_RULE_PATH_BENEATH:
>>> +        err = add_rule_path_beneath(ruleset_fd, rule_attr);
>>> +        break;
>>> +    default:
>>> +        err = -EINVAL;
>>> +        break;
>>> +    }
>>> +    return err;
>>> +}
>>> +
>>>   /* Enforcement */
>>>
>>>   /**
>>> diff --git a/tools/testing/selftests/landlock/base_test.c 
>>> b/tools/testing/selftests/landlock/base_test.c
>>> index da9290817866..0c4c3a538d54 100644
>>> --- a/tools/testing/selftests/landlock/base_test.c
>>> +++ b/tools/testing/selftests/landlock/base_test.c
>>> @@ -156,11 +156,11 @@ TEST(add_rule_checks_ordering)
>>>       ASSERT_LE(0, ruleset_fd);
>>>
>>>       /* Checks invalid flags. */
>>> -    ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 1));
>>> +    ASSERT_EQ(-1, landlock_add_rule(-1, LANDLOCK_RULE_PATH_BENEATH, 
>>> NULL, 1));
>>
>> This must not be changed! I specifically added these tests to make 
>> sure no one change the argument ordering checks…
> 
>    I updated this code cause I got error in base_test.
>    Ok. But in future commints I will order funtions calls in
>    landlock_add_rule() so that base_test runs smoothly (ordering checks).

Right, these tests are correct and they can help you.


> 
>>
>>
>>>       ASSERT_EQ(EINVAL, errno);
>>>
>>>       /* Checks invalid ruleset FD. */
>>> -    ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 0));
>>> +    ASSERT_EQ(-1, landlock_add_rule(-1, LANDLOCK_RULE_PATH_BENEATH, 
>>> NULL, 0));
>>>       ASSERT_EQ(EBADF, errno);
>>>
>>>       /* Checks invalid rule type. */
>>> -- 
>>> 2.25.1
>>>
>> .
