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
  id 877
  arrival_time 18308.824985566298
  lifetime 1232.374002749677
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 35
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 10
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 26
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
]
