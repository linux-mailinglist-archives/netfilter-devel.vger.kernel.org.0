Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3A2737610
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jun 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFTU3Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Jun 2023 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFTU3P (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:29:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DED1727
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b53b8465daso22367975ad.0
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687292948; x=1689884948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA9dgza1t316m8G0sWpsNY6BE+ynDTHmP6tBl5tH3qA=;
        b=CMn9j5Qr0xGH6DPGZmJc+8hF5CS7hFNW/AUBWIcKDkQBdJ5uF/Iv6grWO3k2zaFj5R
         Pcqdzrq3VhdcrvlV/2cztlPSb2r9XJBRdRkJ8sH2KLckg9WUwzrqJmnuo9T18h65CsPj
         Q/sTtqBKU0QjMuls8JQTtSdsBjlIdAXmJUbvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292948; x=1689884948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA9dgza1t316m8G0sWpsNY6BE+ynDTHmP6tBl5tH3qA=;
        b=j91VhOsSIeKjSJATjRD55Y2H28PcqaH3d8H1K2bjx50iILQL7wA6TY/33NzSixp7V0
         ip3cvhb0LFL86Llx1SlUkvLbDnAdSJ9GRdjs1j9prt8LHIR5u+IUgU9rcRAtm8snWjWC
         Imn8C6WnnehiWyivYBXtOw1b4pPbTNCBf3joqev+9mAHIwp+M6g7tOdRKTwurf//g8lY
         tuVzJVpFflKRywzhT8F2Dq466t/WMMawcL6sFkuquF4WmKE6wYID4WW2BHJvCz1+gSKt
         X707uh1lmMUKvHEDmNpaHkLIfdmdgK7ftbS3WurwWtXtgXZSWwFAulJD606TcuLn5fK/
         +NtQ==
X-Gm-Message-State: AC+VfDx+VtqrhCF3/yWCQRVpPrXEs7c7I4c/j5aEo/4u2q32jsnWDk3U
        uPyk/DvEHidiLR7gSDjxb1E8wA==
X-Google-Smtp-Source: ACHHUZ6LzhHQEkbmov28C9WgtfEbYhAG2m29rvQZ0Ua4ICR8aQDGRoXYdt43oeJZee8pqeivB1cpJg==
X-Received: by 2002:a17:903:2311:b0:1b6:6b18:94ff with SMTP id d17-20020a170903231100b001b66b1894ffmr5114043plh.34.1687292948154;
        Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b001b6740207d2sm1990746plh.215.2023.06.20.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:29:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     fw@strlen.de, pablo@netfilter.org, azeemshaikh38@gmail.com,
        kadlec@netfilter.org
Cc:     Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org,
        kuba@kernel.org, pabeni@redhat.com, coreteam@netfilter.org,
        linux-hardening@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: ipset: Replace strlcpy with strscpy
Date:   Tue, 20 Jun 2023 13:28:24 -0700
Message-Id: <168729290242.455922.9357942903753232037.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
References: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, 13 Jun 2023 00:34:37 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Since this got Acked and it's a trivial change, I'll take this via the
hardening tree. Thanks!

Applied to for-next/hardening, thanks!

[1/1] netfilter: ipset: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/0b2fa86361f4

-- 
Kees Cook

