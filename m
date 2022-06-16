Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989054D4D9
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jun 2022 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbiFOWyw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jun 2022 18:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbiFOWyw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:54:52 -0400
Received: from mail-vk1-xa67.google.com (mail-vk1-xa67.google.com [IPv6:2607:f8b0:4864:20::a67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73CC1E9
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jun 2022 15:54:50 -0700 (PDT)
Received: by mail-vk1-xa67.google.com with SMTP id c11so4854703vkn.5
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jun 2022 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rachmadbagus-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=PojBdEXHZ8rzVaM72fh3gUXF7qKQqZdA90U6AbN86kE=;
        b=GNiGQplTTinPvAh5ygTV7XluBS3L1dk8nbWVEdLlLp2Binn33Bm/z8pFgxuEzB4q3n
         NXDpqg1fz30/I27g2Krki27xJtlgctoLsbnO7zCZxPOhaG9VicvIUcx+UL5H9H7ToBT1
         M/kvpqViYXwJPmPYDTuP5ucpQY/22945b/kuW9vpVsrJL3u8369y250NaOXVVP8MP2Hm
         JX8KI/idSuNiqAJIEeRHXjEmMWq2wiO3HmngZqKcNJ2l9M3vdXrkXAASzeX1ELqK/g3n
         TS6JwM0V7KXpba63EnOURow2URaNPL7FUHUxuiywPbpcXOfDEEIJ9WINu+S9G5oZK3TU
         tF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=PojBdEXHZ8rzVaM72fh3gUXF7qKQqZdA90U6AbN86kE=;
        b=bxonlhNjZV26ciE2yTbTSaKBoLrzRCX2O3uHsUO4ysLNEP3EncRB47XtPmFUk6etXN
         BvYOGWwxEHoiLu5SqSmNPJyUeWi/GhxiK/0tSt4U/g4VG8/GmVpJa/rzOaIKjgkFKiGX
         BziaVERpv0GAiGz8ZhmmroRniy/AU0rg4RSqNQxlGkpvmVjeNypyBsqc3HhRAuAgLVil
         s0lwG4X9rmXv9wlO2QiWkAe3BLfNc3d7k876fkZfvCRnIYzY3cYBzJ+XY3HnBD9Iwh+J
         5z7/8Hu1eXtUawbMwrWGVFrSh6OwSjKk1z4lXxjtRKjfMJXwkHktxybQKrFeWwSqEbAS
         ibtQ==
X-Gm-Message-State: AJIora8WJkPMkGPBPudleGyE7KqY5D/F5NHlo0XpiQHGusnIxbErUau7
        2/MzornydcaVqEkiK++9Ucsw2XjtlbKFa+CN1TctOlchnJ96lQ==
X-Google-Smtp-Source: AGRyM1vGqeaM20eG78rMWB6MSBgzqL8XsGoWcAJnMiFJpNVAuZNgT7mRwac0vlm+GdnzZ6uEld8s/ZF6sKzs
X-Received: by 2002:a1f:aad8:0:b0:365:2870:aa89 with SMTP id t207-20020a1faad8000000b003652870aa89mr1275994vke.14.1655333689913;
        Wed, 15 Jun 2022 15:54:49 -0700 (PDT)
Received: from [103.114.217.161] ([103.114.217.161])
        by smtp-relay.gmail.com with ESMTPS id q8-20020ab02b88000000b003626f896607sm23153uar.6.2022.06.15.15.54.49
        for <netfilter-devel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Jun 2022 15:54:49 -0700 (PDT)
X-Relaying-Domain: rachmadbagus.com
Message-ID: <62aa6339.1c69fb81.7f95d.1355SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: URGENT RESPONSE NEEDED
To:     netfilter-devel@vger.kernel.org
From:   Mr <admin5@rachmadbagus.com>
Date:   Wed, 15 Jun 2022 22:54:41 -0700
Reply-To: yingyong@winghang.accountant
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,HK_NAME_MR_MRS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a67 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  1.9 DATE_IN_FUTURE_06_12 Date: is 6 to 12 hours after Received:
        *      date
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.8 HK_NAME_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  2.3 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I'm sorry for sending you this e-mail that ended up in your junk folder as =
unsolicited e-mail. Do you have some time to exchange emails? I want to dis=
cuss a business proposal with you? I know that this business proposal would=
 be of interest to you. For more information please contact me.
