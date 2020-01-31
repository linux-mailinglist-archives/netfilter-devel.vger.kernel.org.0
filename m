Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEEBC14E775
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Jan 2020 04:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgAaDSn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Jan 2020 22:18:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47096 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgAaDSm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:18:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so6167533edi.13
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Jan 2020 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKOQDwQXUKurXAuWrVOtd5P3N/wFMue6QikAKX3EcpA=;
        b=t7tpReGa1k1JnyIbCFwbM5TmbWHFgBovbBf+iZYFT5von/Z6PoihNryV+xtHi/GoUQ
         uNB6ns5HuORLsZVQQtOvu07dNd2Z/ti7nFmxKgtNjCmDq6FaKByIA96muRDAkmMWEN4x
         4leiOv322LvOGdtARMGaF7/X75d1afw2pvNAlSV6sAI1Pc9wTEXK+glcqEeVK6BZAMSa
         SIUZLusMkcSHUBxG5Jp0xxQnhtVCZ5Iprk7hoSXplK+BmPNEPOSnuq6djHMm3izOt536
         IS31amaLztCuToZJU3C53hp9VRbt2tEHKAA33Kb2D8d85muPIAMOFdlE9sN+WfjAhVL5
         Enkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKOQDwQXUKurXAuWrVOtd5P3N/wFMue6QikAKX3EcpA=;
        b=NunnKUWngd5H7dc5dRHD+6YS20ltj6+6T6hRdDzQ8GKfFtwK/7FAxJuvOmtcT/jH0r
         0nTxCNAoA63bKTETqiqHDnSGhlyP7hgn3Uf1gUMtjACu/gZb1PtXCf7+CUMj9GnQxhT2
         KrpgqRASby0m8Nx+CDE4VtK1w0kqGCHR7JZ9pZbE0Fw1xm8EhcgOQkXgLNW938nmTAfw
         eWH/4df+nDk+Fp9eugh1Cb7zzDmv2vAxB5gfa+CeAJyNjQlgXVL0oDtBjr/5sZN9bK0T
         pZebFvmdA3QqxdRDay8e/wzwen3vWFo4G8G8hfNbu7cph8FVweuOy2Gwey7LU5I+2AlP
         mnKw==
X-Gm-Message-State: APjAAAXTRE5mOn4wXomdGQBePXUHPUm3bg0WABU12kQYRImrr7hkXGg5
        QAs1PMER1bmi4UNqSAHqydWRDLMHyMQqNN/ulPPq
X-Google-Smtp-Source: APXvYqw09MWPYLMr7f3uRk+GZfakkhXc+lJFBHeovGHAdcIoR1uSTt46Qff+xrB69Kx1ppYEa5zmxK0semOUo0AFq+k=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr6582030edr.164.1580440721231;
 Thu, 30 Jan 2020 19:18:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577830902.git.rgb@redhat.com> <6768f7c7d9804216853e6e9c59e44f8a10f46b99.1577830902.git.rgb@redhat.com>
 <20200106202306.GO795@breakpoint.cc>
In-Reply-To: <20200106202306.GO795@breakpoint.cc>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:18:29 -0500
Message-ID: <CAHC9VhSuX-f8c-yoph4UB=sHXVuuDLPzRWs19=OVrY+9TBRjkg@mail.gmail.com>
Subject: Re: [PATCH ghak25 v2 8/9] netfilter: add audit operation field
To:     Florian Westphal <fw@strlen.de>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        omosnace@redhat.com, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jan 6, 2020 at 3:23 PM Florian Westphal <fw@strlen.de> wrote:
> Richard Guy Briggs <rgb@redhat.com> wrote:
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 96cabb095eed..5eab4d898c26 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -379,7 +379,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
> >  extern void __audit_fanotify(unsigned int response);
> >  extern void __audit_tk_injoffset(struct timespec64 offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> > -extern void __audit_nf_cfg(const char *name, u8 af, int nentries);
> > +extern void __audit_nf_cfg(const char *name, u8 af, int nentries, int op);
>
> Consider adding an enum instead of int op.
>
> >       if (audit_enabled)
> > -             audit_nf_cfg(repl->name, AF_BRIDGE, repl->nentries);
> > +             audit_nf_cfg(repl->name, AF_BRIDGE, repl->nentries, 1);
>
> audit_nf_cfg(repl->name, AF_BRIDGE, repl->nentries, AUDIT_XT_OP_REPLACE);
>
> ... would be a bit more readable than '1'.
>
> The name is just an example, you can pick something else.

I agree.  Also, please just merge this into patch 4; I don't see a
solid reason why it shouldn't be there.

--
paul moore
www.paul-moore.com
