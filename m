Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DAE3ACB52
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Jun 2021 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhFRMud (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Jun 2021 08:50:33 -0400
Received: from mail.netfilter.org ([217.70.188.207]:50282 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFRMub (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:50:31 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1B9296425E;
        Fri, 18 Jun 2021 14:47:01 +0200 (CEST)
Date:   Fri, 18 Jun 2021 14:48:18 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: nft_extdhr: Drop pointless check of
 tprot_set
Message-ID: <20210618124818.GA10141@salvia>
References: <20210611170826.11412-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210611170826.11412-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:08:26PM +0200, Phil Sutter wrote:
> Pablo says, tprot_set is only there to detect if tprot was set to
> IPPROTO_IP as that evaluates to zero. Therefore, code asserting a
> different value in tprot does not need to check tprot_set.

Applied, thanks.
