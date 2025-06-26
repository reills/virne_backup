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
  id 1437
  arrival_time 30216.261771419315
  lifetime 3825.3112394721393
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 31
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 39
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 43
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
]
