Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D6DA6DE
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438682AbfJQIBO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 04:01:14 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55610 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392718AbfJQIBN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:01:13 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iL0ie-0002E3-GR; Thu, 17 Oct 2019 10:01:12 +0200
Date:   Thu, 17 Oct 2019 10:01:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 4/4] rule: Fix for single line ct timeout printing
Message-ID: <20191017080112.GV25052@breakpoint.cc>
References: <20191016230322.24432-1-phil@nwl.cc>
 <20191016230322.24432-5-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016230322.24432-5-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Commit 43ae7a48ae3de ("rule: do not print semicolon in ct timeout")
> removed an extra semicolon at end of line, but thereby broke single line
> output. The correct fix is to use opts->stmt_separator which holds
> either newline or semicolon chars depending on output mode.

Acked-by: Florian Westphal <fw@strlen.de>
