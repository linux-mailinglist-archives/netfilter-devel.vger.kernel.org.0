Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F811801D9
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2020 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCJPan (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Mar 2020 11:30:43 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46796 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgCJPan (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:30:43 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jBgq9-0004BC-At; Tue, 10 Mar 2020 16:30:41 +0100
Date:   Tue, 10 Mar 2020 16:30:41 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests/py: Move tcpopt.t to any/ directory
Message-ID: <20200310153041.GV979@breakpoint.cc>
References: <20200310151756.10905-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310151756.10905-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Merge tcpopt.t files in ip, ip6 and inet into a common one, they were
> just marignally different.

Thanks, please push this out.
