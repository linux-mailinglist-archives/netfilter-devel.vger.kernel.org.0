Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E163959C
	for <lists+netfilter-devel@lfdr.de>; Sat, 26 Nov 2022 12:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKZLH6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 26 Nov 2022 06:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKZLH6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 26 Nov 2022 06:07:58 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206E11A24
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Nov 2022 03:07:56 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-14279410bf4so7859334fac.8
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Nov 2022 03:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7wrZvAkKeCjMLmhReJxhxYIm3R/2GcWH+genrPm1HQ=;
        b=JJ5IJZwW9HpECy3HtL1LYQ4b2IKV1nA6R9aIXw4BacTunEeolIL83NEJZ29RG1yELs
         C++iAX7EP0/nNyvGWyOnzNgV6MPLe3ifgqRWl0aAnHFBE57kj3TEYkWM+MKfTsykXo4h
         jiBwEV6l4rqBDCqJdMHjWRiYHAHdycDRiMKi271XfkPBMZLtmkqGRKcrKRpx/8DvWobs
         Qo20xbM1NDDC5xcyG08hyj+YsZdr7nDHHVPyDpLywFWjkekkiIXxjfslWcd6UznnWb4u
         ghK9k5GPNSUl0aEN+RHyzDf2oWYZequW7JtIdMWzAvvxUXmWb06Kh6AuzE6MTIEm+DdP
         wOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7wrZvAkKeCjMLmhReJxhxYIm3R/2GcWH+genrPm1HQ=;
        b=yF3OrFdnFwjGH+9U8VVgQ/O5LCBANw4lJWyFBOvKJnCDUh9/33xe4oE/oGfGYH5VLX
         zsaTM2pv7tSNpS7foI1suAhO/A5Udko605uP7Len1tCeHwAZ1atLYcEb8LoN4z28Vyaf
         RYP+duQmHApEmY3jMtQ8nnli/SjniaA5191FxzejpW8eMdstECEWg50T37AtIkNw65ly
         xSjseBL+Hgj9vssIOatlVHog6C8VDK5g8Jm3bpCcmlItFPqOAofZE+SuBsdSaYvfMo3X
         kuP8nFC1YO3mK4mY+fm5Wflp8QJoW9Gf9nddSpBJtZdEhV1Bp9NHUDYMrtT/4ynH/BDL
         uAmQ==
X-Gm-Message-State: ANoB5pkwl5FIjJRN0jQQ6+jsc0+Pigiy1Bk7bfaXAylTHwwDzJZ2TuJz
        83gzrNSYTIWQNN4VAM7xkrkLHAL8p/3GigLuxKY=
X-Google-Smtp-Source: AA0mqf6Y63WJ9AANoy6dxYgqn+wOHkDIrIQgMDLYKlEcjY7dzoH0AubPDQFGL/VFNvW7Pkx4ERhS0IMF3Dnxx7BiiuU=
X-Received: by 2002:a05:6870:7d84:b0:143:4e3e:b8e7 with SMTP id
 oq4-20020a0568707d8400b001434e3eb8e7mr7336636oab.162.1669460876203; Sat, 26
 Nov 2022 03:07:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:9485:b0:dc:ea6c:b582 with HTTP; Sat, 26 Nov 2022
 03:07:55 -0800 (PST)
Reply-To: ninacoulibaly03@myself.com
From:   Nina Coulibaly <regionalmanager.nina@gmail.com>
Date:   Sat, 26 Nov 2022 11:07:55 +0000
Message-ID: <CAHTAA8qLr3R_oBqq0dk3kYuQyP72ePr1v_zd7hqXF_Fg3rtUmQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

-- 
Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
