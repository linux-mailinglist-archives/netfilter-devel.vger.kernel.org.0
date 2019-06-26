Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE05735F
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 23:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFZVM4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 17:12:56 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43584 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfFZVM4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:12:56 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgFDr-0006HH-DD; Wed, 26 Jun 2019 23:12:55 +0200
Date:   Wed, 26 Jun 2019 23:12:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] nftables: tests/py: More tests for day and hour
Message-ID: <20190626211255.5rgtfsc7kogn37bv@breakpoint.cc>
References: <20190626204402.5257-1-a@juaristi.eus>
 <20190626204402.5257-7-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626204402.5257-7-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> I still have some problems to test the 'time' key.
> 
> It always prints one hour earlier than the introduced time,
> even though it works perfectly when I introduce the same rules manually,
> and there is code that specifically checks for that issue by checking TZ to UTC
> and substracting the GMT offset accordingly. Maybe there is some issue with
> env variables or localtime() in the Python test environment?
> 
> Need to investigate further.

If you're stuck let me know and I can take a look at this too.
