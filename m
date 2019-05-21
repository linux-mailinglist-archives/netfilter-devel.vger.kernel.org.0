Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEECB245B3
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 May 2019 03:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfEUBoP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 21:44:15 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:33232 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbfEUBoP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 21:44:15 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hStp8-0005KD-6z; Tue, 21 May 2019 03:44:14 +0200
Date:   Tue, 21 May 2019 03:44:14 +0200
From:   Florian Westphal <fw@strlen.de>
To:     marcmicalizzi@gmail.com
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: nftables flow offload possible mtu handling issue
Message-ID: <20190521014414.wsxqel7ergzzclui@breakpoint.cc>
References: <013801d50ccd$77ef0600$67cd1200$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <013801d50ccd$77ef0600$67cd1200$@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

marcmicalizzi@gmail.com <marcmicalizzi@gmail.com> wrote:
> With flow offload between devices of differing mtus, there seems to be an
> issue sending from through higher mtu to the lower mtu device.
> I’m currently on 4.20 from the linux-arm mcbin branch, as it’s all I can get
> running on my specific embedded platform.

I think i figured out why this is failing, I will send patches later
today.
