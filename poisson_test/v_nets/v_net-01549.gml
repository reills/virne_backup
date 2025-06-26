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
  id 1549
  arrival_time 34187.956601517755
  lifetime 2006.7566029461768
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 29
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 38
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 39
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
]
