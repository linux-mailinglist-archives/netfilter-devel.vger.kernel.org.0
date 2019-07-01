Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5ADE2B8AB
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 May 2019 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfE0QEQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 May 2019 12:04:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35304 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfE0QEQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 May 2019 12:04:16 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hVI6h-0000LD-EB; Mon, 27 May 2019 18:04:15 +0200
Date:   Mon, 27 May 2019 18:04:15 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables v1] iptables-test.py: fix python3
Message-ID: <20190527160415.GZ31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Shekhar Sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190524200206.484692-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524200206.484692-1-shekhar250198@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sat, May 25, 2019 at 01:32:06AM +0530, Shekhar Sharma wrote:
> This patch converts the 'iptables-test.py' file (iptables/iptables-test.py) to run on
> both python 2 and python3.
> 
> Do we need to add an argument for 'version' in the argument parser?

You should insert questions between the '---' marker below and the
diffstat. This way they won't end up in the commit message.

Regarding your question: Assuming that iptables-test.py really is
version agnostic, why should users care which interpreter version is
used? Do you have a use-case in mind which justifies making the
interpreter version selectable via parameter?

[...]
> @@ -79,7 +80,7 @@ def run_test(iptables, rule, rule_save, res, filename, lineno, netns):
>  
>      cmd = iptables + " -A " + rule
>      if netns:
> -            cmd = "ip netns exec ____iptables-container-test " + EXECUTEABLE + " " + cmd
> +            cmd = "ip netns exec ____iptables-container-test " + EXECUTEABLE + "  {}".format(cmd)

Please respect the max column limit of 80 characters, even if the old
code exceeded it already.

Thanks, Phil
