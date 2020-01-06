Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB96131948
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jan 2020 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFUXK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jan 2020 15:23:10 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:37648 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbgAFUXK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:23:10 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ioYu2-0006hD-1J; Mon, 06 Jan 2020 21:23:06 +0100
Date:   Mon, 6 Jan 2020 21:23:06 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        sgrubb@redhat.com, omosnace@redhat.com, fw@strlen.de,
        twoerner@redhat.com, eparis@parisplace.org, ebiederm@xmission.com,
        tgraf@infradead.org
Subject: Re: [PATCH ghak25 v2 8/9] netfilter: add audit operation field
Message-ID: <20200106202306.GO795@breakpoint.cc>
References: <cover.1577830902.git.rgb@redhat.com>
 <6768f7c7d9804216853e6e9c59e44f8a10f46b99.1577830902.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6768f7c7d9804216853e6e9c59e44f8a10f46b99.1577830902.git.rgb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Richard Guy Briggs <rgb@redhat.com> wrote:
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 96cabb095eed..5eab4d898c26 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -379,7 +379,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>  extern void __audit_fanotify(unsigned int response);
>  extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> -extern void __audit_nf_cfg(const char *name, u8 af, int nentries);
> +extern void __audit_nf_cfg(const char *name, u8 af, int nentries, int op);

Consider adding an enum instead of int op.

>  	if (audit_enabled)
> -		audit_nf_cfg(repl->name, AF_BRIDGE, repl->nentries);
> +		audit_nf_cfg(repl->name, AF_BRIDGE, repl->nentries, 1);

audit_nf_cfg(repl->name, AF_BRIDGE, repl->nentries, AUDIT_XT_OP_REPLACE);

... would be a bit more readable than '1'.

The name is just an example, you can pick something else.
