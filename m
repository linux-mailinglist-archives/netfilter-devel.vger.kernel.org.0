Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF93040D
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 May 2019 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfE3VQa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 May 2019 17:16:30 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:57658 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbfE3VQa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 May 2019 17:16:30 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hWSPU-0008Fu-7u; Thu, 30 May 2019 23:16:28 +0200
Date:   Thu, 30 May 2019 23:16:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: nftables release
Message-ID: <20190530211628.lxufmb3gqizywkxe@breakpoint.cc>
References: <65ec483a-b8d7-530b-373f-6dcdd5f668c6@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ec483a-b8d7-530b-373f-6dcdd5f668c6@6wind.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> Hi,
> 
> is there any plan to release an official version of the nftables user-space utility?
> The last one (v0.9.0) is now one year old ;-)

There are a few bugs that are sorted out right now,
a new release should happen soon once that is resolved.
