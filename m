Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D814FA92
	for <lists+netfilter-devel@lfdr.de>; Sat,  1 Feb 2020 21:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgBAU5i (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Feb 2020 15:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgBAU5h (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Feb 2020 15:57:37 -0500
Received: from cakuba.hsd1.ca.comcast.net (c-73-93-4-247.hsd1.ca.comcast.net [73.93.4.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1255C2063A;
        Sat,  1 Feb 2020 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580590657;
        bh=YzrxOAgyAnw5zciHuZGlp4qdwfR8oAZMGYk5eT8mUQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l4EP7P2kgDX1DWaezdJUCChvEvScThz/BPMuNxiM0CFxaW+BZLsUjG1y3Gkxirqeu
         h8cYa/YM/tTZpeZ1MXO0LcxTk4Qh++q5AwDCyB9qvOOWqJG0vrXYiCYCIB0l7i6C6C
         43uJj3tICjzgCNXZrxMsUKUrlfNMBofjOOZzg91M=
Date:   Sat, 1 Feb 2020 12:57:36 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>, Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/6] netfilter: ipset: fix suspicious RCU usage in
 find_set_and_id
Message-ID: <20200201125736.453a0fec@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20200131192428.167274-2-pablo@netfilter.org>
References: <20200131192428.167274-1-pablo@netfilter.org>
        <20200131192428.167274-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, 31 Jan 2020 20:24:23 +0100, Pablo Neira Ayuso wrote:
> From: Kadlecsik J=C3=B3zsef <kadlec@blackhole.kfki.hu>
>=20
> find_set_and_id() is called when the NFNL_SUBSYS_IPSET mutex is held.
> However, in the error path there can be a follow-up recvmsg() without
> the mutex held. Use the start() function of struct netlink_dump_control
> instead of dump() to verify and report if the specified set does not
> exist.
>=20
> Thanks to Pablo Neira Ayuso for helping me to understand the subleties
> of the netlink protocol.
>=20
> Reported-by: syzbot+fc69d7cb21258ab4ae4d@syzkaller.appspotmail.com
> Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

This will trigger a missing signed-off-by check:

Commit 5038517119d5 ("netfilter: ipset: fix suspicious RCU usage in find_se=
t_and_id")
	author Signed-off-by missing
	author email:    kadlec@blackhole.kfki.hu
	committer email: pablo@netfilter.org
	Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
	Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Problem is that the name differs by 'o' vs '=C3=B3' (J=C3=B3zsef Kadlecsik).

I wonder if it's worth getting rid of diacritics for the comparison..
