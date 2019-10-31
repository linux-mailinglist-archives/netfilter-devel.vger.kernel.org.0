Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C525EB47E
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfJaQOw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 12:14:52 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42094 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfJaQOw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:14:52 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iQD63-0001GK-1I; Thu, 31 Oct 2019 17:14:51 +0100
Date:   Thu, 31 Oct 2019 17:14:50 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nf-next 2/2] netfilter: nf_tables: add
 nft_payload_rebuild_vlan_hdr()
Message-ID: <20191031161450.GJ876@breakpoint.cc>
References: <20191031145122.3741-1-pablo@netfilter.org>
 <20191031145122.3741-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031145122.3741-3-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Wrap the code to rebuild the ethernet + vlan header into a function.

Acked-by: Florian Westphal <fw@strlen.de>
