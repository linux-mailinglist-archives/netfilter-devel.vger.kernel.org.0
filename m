Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5713128772E
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Oct 2020 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgJHPbF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Oct 2020 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbgJHPbF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:31:05 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E7C061755
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 08:31:04 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 5B57C58758003; Thu,  8 Oct 2020 17:31:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 57AE560E1940A;
        Thu,  8 Oct 2020 17:31:03 +0200 (CEST)
Date:   Thu, 8 Oct 2020 17:31:03 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] libiptc: Avoid gcc-10 zero-length array
 warning
In-Reply-To: <20201008145822.GA13016@orbyte.nwl.cc>
Message-ID: <q9379q5-3n1-p1r-1ro4-n5q2r086574q@vanv.qr>
References: <20201008130116.25798-1-phil@nwl.cc> <s95qopq1-3o5o-oo9-1qso-osp024914p67@vanv.qr> <20201008145822.GA13016@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2020-10-08 16:58, Phil Sutter wrote:
>
>While the question of whether kernel UAPI headers should adhere to
>strict ISO C or not may be debatable, my motivation for working around
>the situation in user space comes from Gustavo's complaints when I tried
>to convert the relevant struct members into flexible arrays. He
>apparently is a burnt child looking at commit 1e6e9d0f4859e ("uapi:
>revert flexible-array conversions").

Ugh... RDMA.

iptables does not rely or even do such embedding nonsense. When we
have a flexible array member T x[0] or T x[] somewhere, we really do
mean that Ts follow, not some Us like in the RDMA case.

It's probably fair to restore [] for our headers.
