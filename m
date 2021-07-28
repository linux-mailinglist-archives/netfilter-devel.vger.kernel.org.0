Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261EB3D976A
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jul 2021 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhG1VQk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Jul 2021 17:16:40 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39664 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhG1VQk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:16:40 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0927B64175;
        Wed, 28 Jul 2021 23:16:05 +0200 (CEST)
Date:   Wed, 28 Jul 2021 23:16:31 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] doc: ebtables-nft.8: Adjust for missing
 atomic-options
Message-ID: <20210728211631.GA15256@salvia>
References: <20210728155643.31855-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210728155643.31855-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Wed, Jul 28, 2021 at 05:56:43PM +0200, Phil Sutter wrote:
[...]
> +.BR ebtables-save " and " ebtables-restore
> +might replace them entirely given the inherent atomicity of nftables.

Agreed.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
