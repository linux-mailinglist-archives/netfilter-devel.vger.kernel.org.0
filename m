Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF92786817
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Aug 2023 09:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjHXHGI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Aug 2023 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbjHXHFr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:05:47 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B6E4B
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Aug 2023 00:05:45 -0700 (PDT)
Received: from [78.30.34.192] (port=60522 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qZ4PV-00825N-3M; Thu, 24 Aug 2023 09:05:43 +0200
Date:   Thu, 24 Aug 2023 09:05:40 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH] clang-format: add clang-format configuration file
 from Linux kernel
Message-ID: <ZOcBRE869V3ViqDh@calendula>
References: <20230823071134.1573591-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823071134.1573591-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Thomas,

On Wed, Aug 23, 2023 at 09:11:31AM +0200, Thomas Haller wrote:
> Clang-format is useful for developing, even if the code base does not
> enforce an automated style. With this, I can select a function in the
> editor, and reformat that portion with clang-format. In particular, it
> can fix indentation and tabs.
> 
> The style of nftables is close to kernel style, so take the file from
> Linux v6.4 ([1]). There are no changes, except (manually) adjusting
> "ForEachMacros".

I'd prefer you keep this locally by now.

If more developers are relying on this feature, we can revisit later.
