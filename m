Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCED856A3
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Aug 2019 01:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfHGXvG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Aug 2019 19:51:06 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:56924 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729624AbfHGXvG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:51:06 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hvVhx-0004tX-BD; Thu, 08 Aug 2019 01:51:05 +0200
Date:   Thu, 8 Aug 2019 01:51:05 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft 2/2] src: remove global symbol_table
Message-ID: <20190807235105.n5wolugzsxnfvorb@breakpoint.cc>
References: <20190807223924.14067-1-pablo@netfilter.org>
 <20190807223924.14067-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807223924.14067-2-pablo@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Store symbol tables in context object instead.

Looks good to me and works fine for my purposes (no crash anymore),
