Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4F529BE5
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 May 2022 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiEQIL6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 May 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242674AbiEQILC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 May 2022 04:11:02 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F542DDA
        for <netfilter-devel@vger.kernel.org>; Tue, 17 May 2022 01:10:57 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L2TMf4BykzMpnlD;
        Tue, 17 May 2022 10:10:54 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4L2TMf0v4LzlhRV4;
        Tue, 17 May 2022 10:10:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652775054;
        bh=QSvIKgcPbtswa6FCH51xSiVof77XHJ5FF/xz//8wBlY=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
        b=INqGamUJNKXAS6+uYsxv1scucimt4LtXYvj6t9q454KX9iYsfxX4UO7SkNQq1sN0s
         hDpjGIHRYVSC9Yq23XzK9eAuljA0ti4CVPXIim2Tf+GQTrtj7R9QtXkiNQjp6C3tHY
         nxyhyD5dVZD4Gr2IgnT4JtmpaQegMuIrm3zuLrmI=
Message-ID: <ed56f8a3-5469-2b62-ea29-1f7164b0638a@digikod.net>
Date:   Tue, 17 May 2022 10:10:53 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        anton.sirazetdinov@huawei.com
References: <20220516152038.39594-1-konstantin.meskhidze@huawei.com>
 <20220516152038.39594-6-konstantin.meskhidze@huawei.com>
 <9456ccf3-e2b3-bb65-f24f-e6d2761120e5@digikod.net>
Subject: Re: [PATCH v5 05/15] landlock: landlock_add_rule syscall refactoring
In-Reply-To: <9456ccf3-e2b3-bb65-f24f-e6d2761120e5@digikod.net>
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


On 17/05/2022 10:04, Mickaël Salaün wrote:
> You can rename the subject to "landlock: Refactor landlock_add_rule()"
> 
> 
> On 16/05/2022 17:20, Konstantin Meskhidze wrote:

[...]

>> helper was added to support current filesystem rules. It is called
>> by the switch case.
> 
> You can rephrase (all commit messages) in the present form:
present *tense*
> 
> Refactor the landlock_add_rule() syscall to easily support for a new 
> rule type in a following commit. The new add_rule_path_beneath() helper 
> supports current filesystem rules.
