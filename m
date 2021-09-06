Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9513F401A22
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 12:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhIFKtM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Sep 2021 06:49:12 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39386 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhIFKtL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:49:11 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 940EB6001C;
        Mon,  6 Sep 2021 12:47:00 +0200 (CEST)
Date:   Mon, 6 Sep 2021 12:48:00 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] tests/conntrack: script for stress-testing ct load
Message-ID: <20210906104800.GB12944@salvia>
References: <20210823155715.81729-1-mikhail.sennikovskii@ionos.com>
 <20210823155715.81729-2-mikhail.sennikovskii@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823155715.81729-2-mikhail.sennikovskii@ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 23, 2021 at 05:57:14PM +0200, Mikhail Sennikovsky wrote:
> The tests/conntrack/bulk-load-stress.sh is intended to be used for
> stress-testing the bulk load of ct entries from a file (-R option).
> 
> Script usage detail is given by the ./bulk-load-stress.sh -h

Applied with a few edits, thanks.
