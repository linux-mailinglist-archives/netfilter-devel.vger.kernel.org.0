Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4F1B5DDD
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2020 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgDWOeb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Apr 2020 10:34:31 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55196 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbgDWOea (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:34:30 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jRcvp-00041i-An; Thu, 23 Apr 2020 16:34:25 +0200
Date:   Thu, 23 Apr 2020 16:34:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Milan JEANTON <m.jeanton@newquest.fr>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Problem with flushing nftalbes sets
Message-ID: <20200423143425.GE32392@breakpoint.cc>
References: <5a20c054-cf2e-9694-2242-03e1d01cf568@newquest.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a20c054-cf2e-9694-2242-03e1d01cf568@newquest.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Milan JEANTON <m.jeanton@newquest.fr> wrote:
> table ip test {
> ������� set tmp {
> ��������������� type ipv4_addr
> ������� }
> }
> 
> I can add elements in my set without any problem, I can also delete them one
> by one.
> 
> The problem I have is that I need to delete all the elements in the tmp set
> and as precised in the manual of nftables I could flush the elements of a
> set:
> 
> SETS
> [...]
> flush��� Remove all elements from the specified set.
> 
> But when I use the command to flush my sets, it doesn't work and displays me
> an error message
> 
> nft 'flush set test tmp'
> Error: Could not process rule: Invalid argument
> flush set test tmp
> ^^^^^^^^^^^^^^^^^^^

Its expected to work from Linux 4.10 onwards.

# nft list ruleset
table ip test {
        set tmp {
                type ipv4_addr
                elements = { 1.2.3.4, 5.6.7.8 }
        }
}
# nft flush set test tmp
# nft list ruleset
table ip test {
        set tmp {
                type ipv4_addr
        }
}
# uname -sr
Linux 5.5.17
