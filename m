Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF53E1419
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Aug 2021 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhHELtp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Aug 2021 07:49:45 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58762 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhHELto (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:49:44 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5542160030;
        Thu,  5 Aug 2021 13:48:53 +0200 (CEST)
Date:   Thu, 5 Aug 2021 13:49:26 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/2] netfilter: ctnetlink: allow to filter dumps
 via ct->status
Message-ID: <20210805114926.GA13014@salvia>
References: <20210730131422.16958-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730131422.16958-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:14:20PM +0200, Florian Westphal wrote:
> Currently its not possibe to only dump entries that are e.g. in
> UNREPLIED state.
> 
> Patches to extend libnetfilter_conntrack and conntrack-tools will be
> sent separately.

Series applied, thanks.
