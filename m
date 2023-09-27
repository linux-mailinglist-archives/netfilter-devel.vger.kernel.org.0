Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF377B0A82
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjI0Qmt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjI0Qmt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:42:49 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F88DE
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Sep 2023 09:42:46 -0700 (PDT)
Received: from [78.30.34.192] (port=38144 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlXcY-00DVYE-AQ; Wed, 27 Sep 2023 18:42:44 +0200
Date:   Wed, 27 Sep 2023 18:42:41 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/3] nfnl_osf: rework nf_osf_parse_opt() and avoid
 "-Wstrict-overflow" warning
Message-ID: <ZRRbgRny2AHfvV5H@calendula>
References: <20230927122744.3434851-1-thaller@redhat.com>
 <20230927122744.3434851-3-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927122744.3434851-3-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:23:27PM +0200, Thomas Haller wrote:
> We almost can compile everything with "-Wstrict-overflow" (which depends
> on the optimization level). In a quest to make that happen, rework
> nf_osf_parse_opt(). Previously, gcc-13.2.1-1.fc38.x86_64 warned:
> 
>     $ gcc -Iinclude "-DDEFAULT_INCLUDE_PATH=\"/usr/local/etc\"" -c -o tmp.o src/nfnl_osf.c -Werror -Wstrict-overflow=5 -O3
>     src/nfnl_osf.c: In function ‘nfnl_osf_load_fingerprints’:
>     src/nfnl_osf.c:356:5: error: assuming signed overflow does not occur when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>       356 | int nfnl_osf_load_fingerprints(struct netlink_ctx *ctx, int del)
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     src/nfnl_osf.c:356:5: error: assuming signed overflow does not occur when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>     src/nfnl_osf.c:356:5: error: assuming signed overflow does not occur when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>     src/nfnl_osf.c:356:5: error: assuming signed overflow does not occur when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>     src/nfnl_osf.c:356:5: error: assuming signed overflow does not occur when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>     src/nfnl_osf.c:356:5: error: assuming signed overflow does not occur when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>     cc1: all warnings being treated as errors
> 
> The previous code was needlessly confusing. Keeping track of an index
> variable "i" and a "ptr" was redundant. The signed "i" variable caused a
> "-Wstrict-overflow" warning, but it can be dropped completely.
> 
> While at it, there is also almost no need to ever truncate the bits that
> we parse. Only the callers of the new skip_delim_trunc() required the
> truncation.
> 
> Also, introduce new skip_delim() and skip_delim_trunc() methods, which
> point right *after* the delimiter to the next word.  Contrary to
> nf_osf_strchr(), which leaves the pointer at the end of the previous
> part.
> 
> Also, the parsing code using strchr() requires that the overall buffer
> (obuf[olen]) is NUL terminated. And the caller in fact ensured that too.
> There is no point in having a "olen" parameter, we require the string to
> be NUL terminated (which already was implicitly required).  Drop the
> "olen" parameter. On the other hand, it's unclear what ensures that we
> don't overflow the "opt" output buffer. Pass a "optlen" parameter and
> ensure we don't overflow the buffer.

Nice.

IIRC, this code was copied and pasted from iptables. Maybe porting
this patch there would be also good.

BTW, did you test this patch with the pf.os file that nftables ships in?

Thanks!
