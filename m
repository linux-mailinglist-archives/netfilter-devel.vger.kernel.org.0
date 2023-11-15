Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5B7E6E68
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Nov 2023 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjKIQPl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Nov 2023 11:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjKIQPk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:15:40 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED32324A
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Nov 2023 08:15:38 -0800 (PST)
Received: from [78.30.43.141] (port=59052 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r17gs-00FLFu-Mr; Thu, 09 Nov 2023 17:15:36 +0100
Date:   Thu, 9 Nov 2023 17:15:33 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] netlink: fix buffer size for user data in
 netlink_delinearize_chain()
Message-ID: <ZU0FpeSoJreINo2D@calendula>
References: <20231108182230.3999140-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231108182230.3999140-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 08, 2023 at 07:22:20PM +0100, Thomas Haller wrote:
> The correct define is NFTNL_UDATA_CHAIN_MAX and not NFTNL_UDATA_OBJ_MAX.
> In current libnftnl, they both are defined as 1, so (with current libnftnl)
> there is no difference.

Good catch, applied, thanks Thomas.
