Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754A4788809
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Aug 2023 15:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbjHYNCf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 25 Aug 2023 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244933AbjHYNCH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:02:07 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C81FD3
        for <netfilter-devel@vger.kernel.org>; Fri, 25 Aug 2023 06:02:02 -0700 (PDT)
Received: from [78.30.34.192] (port=35844 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qZWRn-00DiJT-2m; Fri, 25 Aug 2023 15:01:58 +0200
Date:   Fri, 25 Aug 2023 15:01:54 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v2 0/6] cleanup base includes and add <nft.h> header
Message-ID: <ZOimQlGWGXFkymRb@calendula>
References: <20230825113810.2620133-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230825113810.2620133-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 25, 2023 at 01:36:28PM +0200, Thomas Haller wrote:
> Changes to v1:
> - rename <nftdefault.h> to <nft.h>
> - move AC_USE_SYSTEM_EXTENSIONS earlier in configure.ac. It must be
>   called before other compiler steps.
> - reword commit messages.

Series applied, thanks
