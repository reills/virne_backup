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
  id 564
  arrival_time 10650.501440101696
  lifetime 1616.9162433422703
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 0
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 23
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 39
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
]
