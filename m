Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3255ABB05
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Sep 2022 01:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiIBXIK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Sep 2022 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIBXIG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:08:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D6F1B4C
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Sep 2022 16:08:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v4so3142408pgi.10
        for <netfilter-devel@vger.kernel.org>; Fri, 02 Sep 2022 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2Y8DDYCQ2otafS/ANml07S73pAs/kgkgSqxooJ7MzEo=;
        b=gZymZsu4nzF/sx2Kz8zdZO31rMaivj6sqqslSfIi8ycb86aOj28XmAjpjIbdkCFQ7r
         1skyr/j6bBsNu89R3L78IRSsABgw3ZrAO6Vc19tV0nU8nt2luO9ZtwPs5x/v28CNEn/2
         k4161ORZTExXAnMbY7/dBGXpFV6cKkAhVn9Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2Y8DDYCQ2otafS/ANml07S73pAs/kgkgSqxooJ7MzEo=;
        b=IrXXdpzVdwjkE4QtG0E9mp2Z97U05Fu3bKmDtC4zgCY8B0RLclRc+UI0kevLxM6J00
         uVzsgyvKkrgCYt8nfZjkwprI0fi36whMHSrxwVrMfcPXQEAr+8jB1Q6Lz6G/z96NRQq3
         k9r/90CSR9iYE0xI2zr4bmD6WoXbQ07IOp3Mmu3J7HxY/qVg4pe30GnKQHZAAb5YwJVL
         oZ80rZfK58ApCcjBwnSAvq42PCJpZGU6SJxV1qTyEA2g8PP14gk8YvS+gwAwY+9x50Ry
         PBdxPWPk5Ph4jONPOrKKIptBpNhbeoXuT2BbeP6AXI6MzOsgDT2smueTsl3LV0EJ6QIa
         f/NA==
X-Gm-Message-State: ACgBeo02hthaSOhi22iZt3TAcUlMbUY86qwhCc4tPglgwrc1Ru4fMY9A
        H9v5LGclW5opwyXMdcHEnR+RJA==
X-Google-Smtp-Source: AA6agR6G3F1xMyBZPBMpPkGlBoDBrXr4WjKwOB3BRE0dZXW8W2Nl66PYsdn9DsbS0atfylWEgULAbw==
X-Received: by 2002:a63:41c5:0:b0:42c:6b7f:6d95 with SMTP id o188-20020a6341c5000000b0042c6b7f6d95mr19124355pga.175.1662160084174;
        Fri, 02 Sep 2022 16:08:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b0016dbaf3ff2esm2207368pls.22.2022.09.02.16.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:08:03 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:08:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        syzbot <syzkaller@googlegroups.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] netlink: Bounds-check struct nlmsgerr creation
Message-ID: <202209021555.9EE2FBD3A@keescook>
References: <20220901071336.1418572-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901071336.1418572-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:13:36AM -0700, Kees Cook wrote:
> For 32-bit systems, it might be possible to wrap lnmsgerr content
> lengths beyond SIZE_MAX. Explicitly test for all overflows, and mark the
> memcpy() as being unable to internally diagnose overflows.
> 
> This also excludes netlink from the coming runtime bounds check on
> memcpy(), since it's an unusual case of open-coded sizing and
> allocation. Avoid this future run-time warning:
> 
>   memcpy: detected field-spanning write (size 32) of single field "&errmsg->msg" at net/netlink/af_netlink.c:2447 (size 16)

To get rid of the above warning...

> [...]
> -		memcpy(&errmsg->msg, nlh, nlh->nlmsg_len);
> +		unsafe_memcpy(&errmsg->msg, nlh, nlh->nlmsg_len,
> +			      /* "payload" was explicitly bounds-checked, based on
> +			       * the size of nlh->nlmsg_len.
> +			       */);

above is the "fix", since the compiler has no way to know how to bounds
check the arguments. But, to write that comment, I added all these
things:

> [...]
> -	if (extack->cookie_len)
> -		tlvlen += nla_total_size(extack->cookie_len);
> +	if (extack->_msg &&
> +	    check_add_overflow(*tlvlen, nla_total_size(strlen(extack->_msg) + 1), tlvlen))
> +		return false;

If that's not desirable, then I guess the question I want to ask is
"what can I put in the unsafe_memcpy() comment above that proves these
values have been sanity checked? In other words, how do we know that
tlvlen hasn't overflowed? (I don't know what other sanity checking may
have already happened, so I'm looking directly at the size calculations
here.)

I assume this isn't more desirable:

-	if (extack->cookie_len)
-		tlvlen += nla_total_size(extack->cookie_len);
+	if (extack->cookie_len) {
+		size_t len = nla_total_size(extack->cookie_len);
+
+		if (WARN_ON_ONCE(len > SIZE_MAX - tlvlen))
+			return 0;
+		tlvlen += len;
+	}

Or maybe wrap it nicely with a local macro and return 0 instead of
trying to pass an error up a layer?

+#define TLVADD(amount)	do { \
+	if (WARN_ON_ONCE(check_add_overflow(tlvlen, amount, &tlvlen))) \
+		return 0; \
+} while (0)

...
	if (extack->cookie_len)
-		tlvlen += nla_total_size(extack->cookie_len);
+		TLVADD(nla_total_size(extack->cookie_len));

-- 
Kees Cook
