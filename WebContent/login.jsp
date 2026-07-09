<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" >
<title>Gateway ERP(Integrated) Copyright &#169; 2017 INK IT Business Solution Pvt Ltd</title>

<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css" />
<style>
/* ═══════════════════════════════════════════════════════════
   PREMIUM SPLIT-PANEL LOGIN — Gateway ERP(Integrated)
   Left  58% : dark brand canvas with logo + features
   Right 42% : clean white sign-in form
   (Design system matched to master INK IT login page)
   ═══════════════════════════════════════════════════════════ */

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html, body {
  width: 100%; height: 100%;
  overflow: hidden;
  font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
}
body { background: #0b1120; }

/* ─── FULL-PAGE SHELL ─── */
.page-shell {
  display: flex;
  width: 100vw;
  height: 100vh;
}

/* ─────────────── LEFT : BRAND PANEL ─────────────── */
.brand-panel {
  flex: 0 0 58%;
  position: relative;
  background: linear-gradient(145deg, #0b1120 0%, #0f1e3c 60%, #0b1120 100%);
  overflow: hidden;
  display: flex;
  flex-direction: column;
  padding: 44px 60px;
}

.brand-panel::before {
  content: '';
  position: absolute;
  top: -200px; right: -180px;
  width: 560px; height: 560px;
  background: radial-gradient(circle, rgba(37,99,235,0.28) 0%, transparent 68%);
  border-radius: 50%;
  pointer-events: none;
}
.brand-panel::after {
  content: '';
  position: absolute;
  bottom: -160px; left: -100px;
  width: 440px; height: 440px;
  background: radial-gradient(circle, rgba(16,185,129,0.16) 0%, transparent 68%);
  border-radius: 50%;
  pointer-events: none;
}

.dot-grid {
  position: absolute; inset: 0;
  background-image: radial-gradient(rgba(255,255,255,0.055) 1px, transparent 1px);
  background-size: 26px 26px;
  pointer-events: none;
  z-index: 0;
}

.bp-logo {
  position: relative; z-index: 2;
  margin-bottom: 0;
}
.bp-logo img {
  height: 40px; width: auto;
  filter: brightness(0) invert(1);
  opacity: 0.92;
}

.bp-body {
  position: relative; z-index: 2;
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 0 0 20px;
}

.bp-eyebrow {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 2.5px;
  text-transform: uppercase;
  color: #60a5fa;
  margin-bottom: 22px;
}
.bp-eyebrow::before {
  content: '';
  display: inline-block;
  width: 28px; height: 2px;
  background: linear-gradient(90deg, #2563eb, #60a5fa);
  border-radius: 2px;
}

.bp-title {
  font-size: clamp(30px, 3.4vw, 50px);
  font-weight: 800;
  line-height: 1.1;
  color: #f1f5f9;
  letter-spacing: -1.5px;
  margin-bottom: 22px;
}
.bp-title .grad {
  background: linear-gradient(90deg, #60a5fa 0%, #34d399 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.bp-tagline {
  font-size: 14.5px;
  line-height: 1.75;
  color: #94a3b8;
  max-width: 400px;
  margin-bottom: 44px;
}

.bp-features {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.bp-features li {
  display: flex;
  align-items: center;
  gap: 14px;
  font-size: 13.5px;
  font-weight: 500;
  color: #cbd5e1;
  line-height: 1.4;
}
.bp-feat-icon {
  flex-shrink: 0;
  width: 28px; height: 28px;
  border-radius: 8px;
  background: rgba(37,99,235,0.18);
  border: 1px solid rgba(59,130,246,0.3);
  display: flex; align-items: center; justify-content: center;
}
.bp-feat-icon svg {
  width: 14px; height: 14px;
  fill: #60a5fa;
}

.bp-stats {
  position: relative; z-index: 2;
  display: flex;
  gap: 0;
  border-top: 1px solid rgba(255,255,255,0.08);
  padding-top: 28px;
  margin-top: auto;
}
.bp-stat {
  flex: 1;
  padding-right: 24px;
}
.bp-stat:not(:first-child) {
  padding-left: 24px;
  border-left: 1px solid rgba(255,255,255,0.08);
}
.bp-stat-n {
  display: block;
  font-size: 26px;
  font-weight: 800;
  color: #f1f5f9;
  letter-spacing: -1px;
  line-height: 1;
  margin-bottom: 4px;
}
.bp-stat-l {
  display: block;
  font-size: 11.5px;
  font-weight: 500;
  color: #64748b;
  text-transform: uppercase;
  letter-spacing: 1px;
}

/* ─────────────── RIGHT : FORM PANEL ─────────────── */
.form-panel {
  flex: 0 0 42%;
  background: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 48px 40px;
  position: relative;
  overflow-y: auto;
}

.form-panel::before {
  content: '';
  position: absolute;
  top: 0; left: 0;
  width: 3px; height: 100%;
  background: linear-gradient(180deg, #2563eb 0%, #10b981 100%);
}

.fp-inner {
  width: 100%;
  max-width: 340px;
}

.fp-logo {
  margin-bottom: 36px;
}
.fp-logo img {
  height: 40px; width: auto;
}

.fp-heading { margin-bottom: 30px; }
.fp-heading h2 {
  font-size: 24px;
  font-weight: 800;
  color: #0f172a;
  letter-spacing: -0.5px;
  margin-bottom: 5px;
}
.fp-heading p {
  font-size: 13.5px;
  color: #64748b;
}

/* stacked fields */
.fp-form {
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.fp-field {
  display: flex;
  flex-direction: column;
  gap: 7px;
}

.fp-label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.fp-field label,
.fp-label-row label {
  font-size: 12.5px;
  font-weight: 600;
  color: #374151;
  letter-spacing: 0.1px;
}

/* select */
.fp-field select {
  width: 100%;
  height: 46px;
  padding: 0 14px;
  font-size: 14px;
  font-weight: 500;
  color: #0f172a;
  background: #f8fafc;
  border: 1.5px solid #e2e8f0;
  border-radius: 10px;
  appearance: auto;
  cursor: pointer;
  outline: none;
  transition: border-color 0.18s, box-shadow 0.18s, background 0.18s;
  font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
}
.fp-field select:focus {
  border-color: #2563eb;
  background: #fff;
  box-shadow: 0 0 0 3px rgba(37,99,235,0.12);
}

/* text / password input */
.fp-input-wrap {
  position: relative;
  display: flex;
  align-items: center;
}
.fp-icon {
  position: absolute;
  left: 14px;
  font-size: 14px;
  color: #94a3b8;
  pointer-events: none;
  z-index: 1;
}
.fp-field input[type="text"],
.fp-field input[type="password"] {
  width: 100%;
  height: 46px;
  padding: 0 14px 0 40px;
  font-size: 14px;
  color: #0f172a;
  background: #f8fafc;
  border: 1.5px solid #e2e8f0;
  border-radius: 10px;
  outline: none;
  font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
  transition: border-color 0.18s, background 0.18s, box-shadow 0.18s;
}
.fp-field input:focus {
  border-color: #2563eb;
  background: #fff;
  box-shadow: 0 0 0 3px rgba(37,99,235,0.12);
}
.fp-field input::placeholder { color: #b0bec5; font-size: 13px; }

/* forgot link */
.forgotpwd {
  font-size: 12px;
  font-weight: 600;
  color: #2563eb;
  text-decoration: none;
  cursor: progress;
  transition: color 0.15s;
}
.forgotpwd:hover { color: #1d4ed8; text-decoration: underline; }

/* sign-in button */
.btnlogin {
  width: 100%;
  height: 48px;
  margin-top: 6px;
  background: linear-gradient(135deg, #1d4ed8 0%, #2563eb 60%, #3b82f6 100%);
  border: none;
  border-radius: 10px;
  color: #fff;
  font-size: 15px;
  font-weight: 700;
  letter-spacing: 0.3px;
  text-transform: uppercase;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: transform 0.15s, box-shadow 0.18s;
  box-shadow: 0 6px 22px rgba(37,99,235,0.38);
  font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
}
.btnlogin::after {
  content: '';
  position: absolute; inset: 0;
  background: linear-gradient(to bottom, rgba(255,255,255,0.10), transparent);
}
.btnlogin:hover,
.btnlogin:active,
.btnlogin:focus {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(37,99,235,0.48);
  color: #fff;
  background: linear-gradient(135deg, #1d4ed8 0%, #2563eb 60%, #3b82f6 100%);
}

/* footer */
.fp-footer {
  margin-top: 30px;
  text-align: center;
  font-size: 11.5px;
  color: #94a3b8;
}

/* ─────────────── FORGOT-PASSWORD WIZARD ─────────────── */
.wizard-container {
  position: fixed;
  z-index: 9999;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  width: 400px;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 24px 80px rgba(0,0,0,0.22), 0 0 0 1px rgba(0,0,0,0.06);
  overflow: hidden;
  opacity: 0;
  display: none;
  transition: opacity 0.25s ease;
}
.wizard-container.active { opacity: 1; }

.wizard-container h3 {
  background: linear-gradient(135deg, #1d4ed8, #3b82f6);
  color: #fff;
  font-size: 14px;
  font-weight: 700;
  padding: 15px 48px 15px 20px;
  margin: 0;
  text-align: left;
}
.btnwizardclose-container {
  position: absolute;
  top: 11px; right: 14px;
  float: none;
  margin: 0;
}
.btnwizardclose-container a i { color: rgba(255,255,255,0.75); font-size: 15px; }
.btnwizardclose-container a:hover i { color: #fff; }

.tabcontrols-container {
  display: flex;
  border-bottom: 1px solid #f1f5f9;
  width: 100%;
}
.tab-control {
  flex: 1; text-align: center;
  padding: 11px 0;
  font-size: 12.5px; font-weight: 600;
  color: #94a3b8;
  background: #fafbfc;
  border: none; cursor: pointer;
  border-bottom: 2px solid transparent;
  transition: color 0.15s, border-color 0.15s, background 0.15s;
  font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
  float: none;
  margin-bottom: 0;
  width: auto;
}
.tab-control.active {
  color: #2563eb;
  background: #fff;
  border-bottom-color: #2563eb;
  transform: none;
  box-shadow: none;
}

.tab-content-container { width: 100%; }
.tab-content { padding: 18px 20px; display: none; width: 100%; }

/* wizard input group */
.wizard-container .input-group {
  display: flex;
  border: 1.5px solid #e2e8f0;
  border-radius: 10px;
  overflow: hidden;
}
.wizard-container .input-group-addon {
  background: #f8fafc;
  border: none;
  border-right: 1.5px solid #e2e8f0;
  width: 40px;
  display: flex; align-items: center; justify-content: center;
  color: #94a3b8;
  flex-shrink: 0;
}
.wizard-container .form-control {
  flex: 1;
  height: 42px;
  border: none;
  outline: none;
  padding: 0 12px;
  font-size: 14px;
  background: transparent;
  color: #0f172a;
  font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
}
.help-block { font-size: 12px; color: #ef4444; margin-top: 6px; display: block; }

.btn-next {
  float: right; margin-top: 10px; margin-right: 0;
  width: 34px; height: 34px;
  background: #2563eb; color: #fff;
  border: none; border-radius: 50%;
  cursor: pointer; font-size: 15px;
  box-shadow: 0 4px 12px rgba(37,99,235,0.3);
  transition: background 0.15s, transform 0.15s;
  display: flex; align-items: center; justify-content: center;
}
.btn-next:hover,
.btn-next:active,
.btn-next:focus {
  background: #1d4ed8;
  border-color: #1d4ed8;
  color: #fff;
  transform: translateX(2px);
  box-shadow: 0 4px 12px rgba(37,99,235,0.3);
}

.instructions {
  text-align: center; color: #475569;
  font-size: 13px; line-height: 1.7;
  padding: 8px 0 12px;
}
.btn-dismiss {
  display: block; width: 100%;
  margin-top: 10px;
  padding: 10px 0;
  background: #f1f5f9; color: #475569;
  border: none; border-radius: 8px;
  font-size: 13px; font-weight: 700;
  cursor: pointer; text-transform: uppercase; letter-spacing: 0.5px;
  transition: background 0.15s;
  font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
}
.btn-dismiss:hover,
.btn-dismiss:active {
  background: #e2e8f0;
  color: #475569;
  border-color: transparent;
  box-shadow: none;
}

/* hide legacy layout classes / offscreen decorative markup that
   the master design no longer displays, kept in DOM only for the
   unmodified JS to reference without altering behaviour */
.outer-container, .vertical-login, .block-login, .bg-svg,
.login-container, .first, .second, .header-image,
.login-group, .rowgap, .container-fluid.login-control-container {
  all: unset;
}
.outer-container, .vertical-login, .block-login, .bg-svg {
  display: none;
}
</style>
</head>
<body autocomplete="off" onload="getComp();">

<!-- legacy decorative / animation-target markup retained off-screen so the
     unmodified JS (anime.js targets, login-text typewriter, etc.) keeps
     running exactly as before, without altering visible behaviour -->
<div class="outer-container">
    <div class="block-login">
        <h2></h2>
    </div>
    <div class="vertical-login">
        <span class="login-text"></span>
        <span class="login-line"></span>
    </div>
    <div class="bg-svg">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 960 560" style="enable-background:new 0 0 960 560;" xml:space="preserve">
<style type="text/css">
    .st0{fill:none;stroke:#999999;stroke-miterlimit:10;opacity: 0;}
    .st1{fill:none;stroke:#FF0000;stroke-width:11;stroke-miterlimit:10;opacity: 0;}
    .st2{fill:none;stroke:#0000FF;stroke-width:11;stroke-miterlimit:10;opacity: 0;}
    .st3{fill:none;stroke:#C111B0;stroke-width:11;stroke-miterlimit:10;opacity: 0;}
</style>
<ellipse id="inner-circle" class="st0" cx="280.7" cy="267.5" rx="84.3" ry="83"/>
<ellipse id="middle-circle" class="st0" cx="280.7" cy="267.1" rx="166.3" ry="164.2"/>
<ellipse id="outer-circle" class="st0" cx="276.5" cy="267" rx="238.5" ry="242"/>
<ellipse id="outer-sub-circle" class="st1" cx="175.7" cy="47.9" rx="16.3" ry="16"/>
<ellipse id="middle-sub-circle" class="st2" cx="131" cy="338.6" rx="16.3" ry="16"/>
<ellipse id="inner-sub-circle" class="st3" cx="306.7" cy="192.9" rx="16.3" ry="16"/>
</svg>
    </div>
</div>

<div class="page-shell">

  <!-- ────────── LEFT : BRAND PANEL ────────── -->
  <div class="brand-panel">
    <div class="dot-grid"></div>

    <div class="bp-logo">
      <img src="icons/ink_new_logo_2025.png" alt="INK IT Business Solutions">
    </div>

    <div class="bp-body">
      <span class="bp-eyebrow">Enterprise Resource Planning</span>

      <h1 class="bp-title">
        Smarter ERP for<br>
        <span class="grad">Modern Business</span>
      </h1>

      <p class="bp-tagline">
        A unified platform to manage car rental, fleet, finance, HR, and operations —
        all from a single, powerful workspace.
      </p>

      <ul class="bp-features">
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M3 4h14v2H3V4zm0 4h10v2H3V8zm0 4h14v2H3v-2z"/></svg>
          </span>
          Multi-branch Operations &amp; Fleet Management
        </li>
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M2 11l8-8 8 8v7a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-7z"/></svg>
          </span>
          Real-time Financial Reports &amp; Analytics
        </li>
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M10 10a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm-7 8a7 7 0 0 1 14 0H3z"/></svg>
          </span>
          Integrated HR, Payroll &amp; Leave Management
        </li>
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M7.629 15.314l-4.71-4.71 1.414-1.415 3.296 3.296 8.042-8.042 1.414 1.414z"/></svg>
          </span>
          Approval Workflows &amp; Role-based Access Control
        </li>
      </ul>
    </div>

    <div class="bp-stats">
      <div class="bp-stat">
        <span class="bp-stat-n">33+</span>
        <span class="bp-stat-l">Modules</span>
      </div>
      <div class="bp-stat">
        <span class="bp-stat-n">Multi</span>
        <span class="bp-stat-l">Branch</span>
      </div>
      <div class="bp-stat">
        <span class="bp-stat-n">24 / 7</span>
        <span class="bp-stat-l">Support</span>
      </div>
    </div>
  </div><!-- /.brand-panel -->


  <!-- ────────── RIGHT : FORM PANEL ────────── -->
  <div class="form-panel">
    <div class="fp-inner">

      <div class="fp-logo">
        <img src="icons/ink_new_logo_2025.png" alt="INK IT">
      </div>

      <div class="fp-heading">
        <h2>Welcome back</h2>
        <p>Sign in to your workspace</p>
      </div>

      <form method="post" action="login" autocomplete="off" class="fp-form">

        <div class="fp-field">
          <label for="company">Company</label>
          <select name="company" id="company" required="required"></select>
        </div>

        <div class="fp-field">
          <label for="username">Username</label>
          <div class="fp-input-wrap">
            <i class="glyphicon glyphicon-user fp-icon"></i>
            <input id="username" type="text" class="form-control" name="userid" placeholder="Enter your username">
          </div>
        </div>

        <div class="fp-field">
          <div class="fp-label-row">
            <label for="password">Password</label>
            <a class="forgotpwd" tabindex="-1">Forgot Password ?</a>
          </div>
          <div class="fp-input-wrap">
            <i class="glyphicon glyphicon-lock fp-icon"></i>
            <input id="password" type="password" class="form-control" name="password" placeholder="••••••••">
          </div>
        </div>

        <button type="submit" class="btn btn-default btnlogin" id="btnlogin"><span>Sign In</span></button>

        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>

      </form>

      <p class="fp-footer">&copy; 2017 INK IT Business Solution Pvt Ltd. All rights reserved.</p>

    </div>
  </div><!-- /.form-panel -->

</div><!-- /.page-shell -->


<!-- ────────── FORGOT-PASSWORD WIZARD (IDs kept for JS) ────────── -->
<div class="wizard-container img-rounded">
    <span class="btnwizardclose-container"><a href="" class="btnwizardclose"><i class="fa fa-times"></i></a></span>
    <h3 class="text-center">Forgot Password Wizard</h3>
    <div class="tabcontrols-container">
        <button type="button" class="btn btn-default tab-control active" data-tab="step1" id="btnstep1">Step 1</button>
        <button type="button" class="btn btn-default tab-control" data-tab="step2" id="btnstep2">Step 2</button>
    </div>
    <div class="tab-content-container">
        <div class="tab-content" id="step1">
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    <input type="email" class="form-control" id="forgotemail" name="forgotemail" placeholder="Enter Email">
                </div>
                <span class="glyphicon form-control-feedback"></span>
                <span class="help-block">&nbsp;</span>
            </div>
            <button type="button" class="btn btn-default btn-next"><i class="fa fa-chevron-right"></i></button>
        </div>
        <div class="tab-content" id="step2">
            <p class="instructions"></p>
            <div class="text-center"><button type="button" class="btn btn-default btn-dismiss">dismiss</button></div>
        </div>
    </div>
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
    <script type="text/javascript">
    	
    	$(document).ready(function(){

    		if($('#msg').val()!="" ) {
    			$.messager.alert('Login Failed',$('#msg').val());
    		}
    		
    		 $('body').keydown(function (evt) {
    			  if (evt.keyCode == 8) {
    				  var d = event.srcElement || event.target;
    			        if ((d.tagName.toUpperCase() === 'INPUT' && 
    			             (
    			                 d.type.toUpperCase() === 'TEXT' ||
    			                 d.type.toUpperCase() === 'PASSWORD' || 
    			                 d.type.toUpperCase() === 'FILE' || 
    			                 d.type.toUpperCase() === 'EMAIL' || 
    			                 d.type.toUpperCase() === 'SEARCH' || 
    			                 d.type.toUpperCase() === 'DATE' )
    			             ) || 
    			             d.tagName.toUpperCase() === 'TEXTAREA') {
    			            doPrevent = d.readOnly || d.disabled;
    			        }
    			        else {
    			            doPrevent = true;
    			        }
    			    }
    			    if (doPrevent) {
    			        event.preventDefault();
    				}
    		}); 

    		
    	    $("input").not($(":button")).keypress(function (evt) {
    	        if (evt.keyCode == 13) {
    	            iname = $(this).val();
    	            if (iname !== 'Submit') {
    	                var fields = $(this).parents('form:eq(0),body').find('button, input, textarea, select');
    	                var index = fields.index(this);
    	                if (index > -1 && (index + 1) < fields.length) {
    	                    fields.eq(index + 1).focus();
    	                }
    	                return false;
    	            }
    	        }
    	    });
    		
    		var theLetters = "abcdefghijklmnopqrstuvwxyz#%&^+=-"; //You can customize what letters it will cycle through
    		var ctnt = "Login"; // Your text goes here
    		var speed = 50; // ms per frame
    		var increment = 8; // frames per step. Must be >2

    		    
    		var clen = ctnt.length;       
    		var si = 0;
    		var stri = 0;
    		var block = "";
    		var fixed = "";
    		//Call self x times, whole function wrapped in setTimeout
    		(function rustle (i) {          
    		setTimeout(function () {
    		  if (--i){rustle(i);}
    		  nextFrame(i);
    		  si = si + 1;        
    		}, speed);
    		})(clen*increment+1); 
    		function nextFrame(pos){
    		  for (var i=0; i<clen-stri; i++) {
    		    //Random number
    		    var num = Math.floor(theLetters.length * Math.random());
    		    //Get random letter
    		    var letter = theLetters.charAt(num);
    		    block = block + letter;
    		  }
    		  if (si == (increment-1)){
    		    stri++;
    		  }
    		  if (si == increment){
    		  // Add a letter; 
    		  // every speed*10 ms
    		  fixed = fixed +  ctnt.charAt(stri - 1);
    		  si = 0;
    		  }
    		  $(".login-text").html(fixed + block);
    		  $(".block-login h2").html(fixed + block);
    		  
    		  block = "";
    		}
    		anime({
    			  targets: '#inner-circle',
    			  strokeDashoffset: [anime.setDashoffset, 0],
    			  opacity:1,
    			  duration: 5000,
    			  delay: 200
    		});
   			anime({
   			  targets: '#middle-circle,#inner-sub-circle',
   			  strokeDashoffset: [anime.setDashoffset, 0],
   			  opacity:1,
   			  duration: 5000,
   			  delay: 700
   			});
   			anime({
   			  targets: '#outer-circle,#middle-sub-circle',
   			  strokeDashoffset: [anime.setDashoffset, 0],
   			  opacity:1,
   			  duration: 5000,
   			  delay: 1200
   			});
   			anime({
   			  targets: '#outer-sub-circle',
   			  strokeDashoffset: [anime.setDashoffset, 0],
   			  opacity:1,
   			  duration: 5000,
   			  delay: 1700
   			});
   			$('.wizard-container').fadeOut();
   			$('.forgotpwd').click(function(){
   				$("#forgotemail").val('');
   				$('#btnstep2').removeClass('active');
   				$('#btnstep1').addClass('active');
   			    if($('.wizard-container').hasClass('active')){
   			        $('.wizard-container').fadeOut();
   			    }
   			    else{
   			    	$('#step2').fadeOut();
   	   				$('#step1').fadeIn();
   			    	$('.wizard-container').fadeIn();    
   			    }
   			    $('.wizard-container').toggleClass('active');
   			    
   			});
   			
   			$('.wizard-container').keyup(function(e){
   			    if (e.keyCode == 27) { 
   			        $(this).fadeOut();
   			    }
   			});
   			$('.btnwizardclose').click(function(){
   				$('.wizard-container').toggleClass('active');
   				$('.wizard-container').fadeOut('fast');
   				return false;
   			});
   			$('.btn-next').click(function(){
   			    var email = $("#forgotemail").val();
   			    if (validateEmail(email)) {
   			        if($('#step1 .form-group').hasClass('has-error has-feedback')){
   			            $('#step1 .form-group').removeClass('has-error has-feedback');   
   			            $('#step1 .form-group .form-control-feedback').removeClass('glyphicon-remove');
   			            $('.help-block').text("");
   			        }
   			     validateEmailDB(email);
   			    }
   			    else{
   			        $('#step1 .form-group').addClass('has-error has-feedback');
   			        $('#step1 .form-group .form-control-feedback').addClass('glyphicon-remove');
   			        $('.help-block').text("Please enter valid email");
   			    }
   			});

   			$('.btn-dismiss').click(function(){
   				$('.wizard-container').toggleClass('active');
   				$('.wizard-container').fadeOut('fast');
   				
   			});
    	});

    	   function validateEmail(email) {
               var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
               return re.test(email);
           }

           function validateEmailDB(email)
        	{ 
        	   var x=new XMLHttpRequest();
               x.onreadystatechange=function(){
                   if (x.readyState==4 && x.status==200)
                   {
                       items= x.responseText.trim();
                       if(items=="1"){
                    	   $('#step1').hide();
                    	   if($('#step1 .form-group').hasClass('has-error has-feedback')){
          			            $('#step1 .form-group').removeClass('has-error has-feedback');   
          			            $('#step1 .form-group .form-control-feedback').removeClass('glyphicon-remove');
          			            $('.help-block').text("");
          			        }
                    	   $('#btnstep1').removeClass('active');
                    	   $('#btnstep2').addClass('active');
                           
                           $('.instructions').text("The login credentials has been sent to the Email "+email+".Thank You");
                           $('#step2').fadeIn();
                       }
                       else{
                    	   $('#step1 .form-group').addClass('has-error has-feedback');
          			       $('#step1 .form-group .form-control-feedback').addClass('glyphicon-remove');
                           $('.help-block').text("We couldn't find any account related this email.Please enter valid email");
                       }
                       
                   }
               else
                   {
                   }
           }
           x.open("GET","checkForgotEmail.jsp?email="+email,true);
           x.send();
       
           }

           
    	function getComp()
    	{
	   		var x=new XMLHttpRequest();
	   		var items,cmpItems;
    		x.onreadystatechange=function(){
    	    	if (x.status == 500) {
    	        	chkcompany();
    		    }
    			if (x.readyState==4 && x.status==200)
    				{
    			        items= x.responseText;
    			        if(items.trim()=="NOTGET")
    			        	{
    			        	chkcompany();
    			        	return 0;
    			        	}
    			        else
    			        	{
	    			         items=items.split('####');
    				         var cmpItems = items[0].split(",");
    					     var cmpIdItems = items[1].split(",");
    			        	 var optionscmp = '';
    			       		 for ( var i = 0; i < cmpItems.length; i++) {
    			    	   		optionscmp += '<option value="' + cmpIdItems[i] + '">' + cmpItems[i] + '</option>';
    			        	 }
    			        	 $("select#company").html(optionscmp);
    			        	 
    			        	}
    				}
    			else
    				{
    				}
    		}
    		x.open("GET","getCompany.jsp",true);
    		x.send();
    	}

    	  function chkcompany()
    		{
    		 var company=$("#company").val();
    		 if(!(parseInt(company)>0))
    		 	{  
	    	       setInterval(function(){ 
			    		window.location.reload(true);
    			   }, 3000);
    			}
    			else
    				{
    				}
    		}
    </script>
</body>
</html>
