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
  id 529
  arrival_time 10103.52500607899
  lifetime 1809.0438751654456
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 29
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 50
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 30
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 45
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 22
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
]
