Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0779F28C
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Sep 2023 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjIMUDR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 13 Sep 2023 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMUDQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:03:16 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88950173C;
        Wed, 13 Sep 2023 13:03:12 -0700 (PDT)
Received: from [37.29.152.45] (port=2138 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qgW4m-002JBe-Vw; Wed, 13 Sep 2023 22:03:10 +0200
Date:   Wed, 13 Sep 2023 22:03:01 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        audit@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com
Subject: Re: [nf PATCH v3 0/2] nf_tables: follow-up on audit fix, add selftest
Message-ID: <ZQIVdRZrz8TA2dEu@calendula>
References: <20230913135137.15154-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913135137.15154-1-phil@nwl.cc>
X-Spam-Score: -1.9 (-)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 13, 2023 at 03:51:35PM +0200, Phil Sutter wrote:
> Patch f1 fixes/improves Pablo's fix for the bug I built into nf_tables'
> audit support code.
> 
> Patch 2 adds a selftest for the audit notifications in nf_tables. I
> consider it mature enough to submit it as non-RFC now.
> 
> Larger changes in both patches, details in each patch.

Series applied, thanks
