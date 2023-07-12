Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6C750167
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Jul 2023 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjGLI0d (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Jul 2023 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjGLI0C (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:26:02 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ED0235B6;
        Wed, 12 Jul 2023 01:21:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:19:45 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     netfilter-devel@vger.kernel.org, sashal@kernel.org,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH -stable,5.10,v2 01/11] netfilter: nf_tables: use
 net_generic infra for transaction data
Message-ID: <ZK5iIeiOAxEsuWzt@calendula>
References: <20230705150011.59408-1-pablo@netfilter.org>
 <20230705150011.59408-2-pablo@netfilter.org>
 <ZK5C6EL6Fz0o3w2D@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZK5C6EL6Fz0o3w2D@eldamar.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:06:32AM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Wed, Jul 05, 2023 at 05:00:01PM +0200, Pablo Neira Ayuso wrote:
> > From: Florian Westphal <fw@strlen.de>
> > 
> > [ 0854db2aaef3fcdd3498a9d299c60adea2aa3dc6 ]
> 
> For all patches in this series, that should be either
> 
> [ Upstream commit 0854db2aaef3fcdd3498a9d299c60adea2aa3dc6 ]
> 
> or
> 
> commit 0854db2aaef3fcdd3498a9d299c60adea2aa3dc6 upstream.

I will fix this and submit a v3.

Thanks
