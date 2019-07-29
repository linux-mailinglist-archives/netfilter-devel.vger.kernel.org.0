Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1B782B0
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 02:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfG2AI6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 28 Jul 2019 20:08:58 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:59532 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbfG2AI6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:08:58 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hrtDh-0007t9-OE; Mon, 29 Jul 2019 02:08:53 +0200
Date:   Mon, 29 Jul 2019 02:08:53 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: add include guard to xt_connlabel.h
Message-ID: <20190729000853.fag4i725addbfg4y@breakpoint.cc>
References: <20190728155138.29803-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728155138.29803-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Add a header include guard just in case.

Acked-by: Florian Westphal <fw@strlen.de>
