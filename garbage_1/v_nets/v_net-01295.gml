graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1295
  arrival_time 27091.8058214699
  lifetime 874.8496236335607
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 0
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 30
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
]
